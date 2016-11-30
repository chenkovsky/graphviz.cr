class GraphViz
  class FamilyTree
    class Person
      @graph : GraphViz
      @tree : FamilyTree
      @generation : Generation
      @sibling : Sibling?
      @node : Node

      def initialize(@graph, @tree, @generation, id : String)
        @node = @graph.add_nodes(id)
        @node["shape"] = "box"
        @x, @y = 0, 0
        @sibling = nil
      end

      delegate :id, to: @node

      def name
        @node.label || @node.id
      end

      property :sibling
      getter :node

      # Define the current person as a man
      #
      #  greg.is_a_man( "Greg" )
      def is_a_man(name)
        @node["label"] = name
        @node["color"] = "blue"
      end

      # Define the current person as a boy
      #
      #  greg.is_a_boy( "Greg" )
      def is_a_boy(name)
        is_a_man(name)
      end

      # Define the current perdon as a woman
      #
      #  mu.is_a_woman( "Muriel" )
      def is_a_woman(name)
        @node["label"] = name
        @node["color"] = "pink"
      end

      # Define the current perdon as a girl
      #
      #  maia.is_a_girl( "Maia" )
      def is_a_girl(name)
        is_a_woman(name)
      end

      # Define that's two persons are maried
      #
      #  mu.is_maried_with greg
      def is_maried_with(x)
        node = @graph.add_nodes("#{@node.id}And#{x.node.id}")
        node["shape"] = "point"
        @graph.add_edges @node, node, dir: "none"
        @graph.add_edges node, x.node, dir: "none"
        @tree.add_couple self, x, node
      end

      # Define that's two persons are divorced
      #
      #  sophie.is_divorced_with john
      def is_divorced_with(x)
        node = @graph.add_nodes("#{@node.id}And#{x.node.id}")
        node["shape"] = "point"
        node["color"] = "red"
        @graph.add_edges(@node, node, dir: "none", color: "red")
        @graph.add_edges(node, x.node, dir: "none", color: "red")
        @tree.add_couple(self, x, node)
      end

      # Define that's a person is widower of another
      #
      #  simon.is_widower_of elisa
      def is_widower_of(x) # veuf
        node = @graph.add_nodes("#{@node.id}And#{x.node.id}")
        node["shape"] = "point"
        node["color"] = "green"
        @graph.add_edges(@node, node, dir: "none", color: "green")
        @graph.add_edges(node, x.node, dir: "none", color: "green")
        @tree.add_couple(self, x, node)
      end

      # Define the current person as dead
      #
      #  jack.is_dead
      def is_dead
        @node["style"] = "filled"
      end

      # Define the kids of a single person
      #
      #   alice.kids( john, jack, julie )
      def kids(*z)
        GraphViz::FamilyTree::Couple.new(@graph, @node, [self]).kids(z)
      end

      def kids(z : Array(Person))
        GraphViz::FamilyTree::Couple.new(@graph, @node, [self]).kids(z)
      end
    end

    class Couple
      @graph : GraphViz
      @node : Node
      @kids : Sibling?

      def initialize(@graph, @node, @persons, @kids = nil)
      end

      getter :node

      def kids(*z)
        kids(z.to_a)
      end

      # Add kids to a couple
      def kids(z : Array(Person))
        @kids = GraphViz::FamilyTree::Sibling.new(z, @persons)

        return

        if z.size == 1
          @graph.add_edges(@node, z[0].node, dir: "none")
        else
          cluster = @graph.add_graph("#{@node.id}Kids")
          cluster["rank"] = "same"

          last = nil
          count = 0
          add = (z.size - 1) % 2 * z.size/2 + (z.size - 1) % 2
          link = (z.size/2) + 1

          z.each do |person|
            count = count + 1
            if count == add
              middle = cluster.add_nodes "#{@node.id}Kids", shape: "point"
              @graph.add_edges @node, middle, dir: "none"
              unless last.nil?
                cluster.add_edges last, middle, dir: "none"
              end
              last = middle
            end

            kid = cluster.add_nodes "#{person.node.id}Kid", shape: "point"
            @graph.add_edges kid, person.node, dir: "none"

            if add == 0 && count == link
              @graph.add_edges @node, kid, dir: "none"
            end

            unless last.nil?
              cluster.add_edges last, kid, dir: "none"
            end
            last = kid
          end
        end
      end

      def getKids
        @kids
      end
    end

    class Generation
      @graph : GraphViz
      @persons : Hash(String, Person)
      @all_persons : Hash(String, Person)
      @tree : FamilyTree
      @gen_number : Int32

      def initialize(@graph, persons, @tree, @gen_number)
        @all_persons = persons
        @persons = {} of String => Person
      end

      getter :all_persons, :persons

      def make
        with self yield
      end

      macro method_missing(sym)
        all_persons[{{call.name.id.stringify}}] ||= (persons[{{call.name.id.stringify}}] ||= Person.new(@graph, @tree, self, {{call.name.id.stringify}}))
      end

      # Generation number
      def number
        @gen_number
      end

      delegate :size, :to, @persons
    end

    class Sibling
      def initialize(@brothers_and_sisters : Array(Person), @parents : Array(Person))
        @brothers_and_sisters.each do |person|
          person.sibling = self
        end
      end
    end

    # Create a new family tree
    #
    #   require 'graphviz/family_tree'
    #   t = GraphViz::FamilyTree.new do
    #     ...
    #   end
    def initialize(@persons = {} of String => Person,
                   @graph = GraphViz.new("FamilyTree", use: :neato),
                   @generation_number = 0,
                   @generations = [] of Generation,
                   @couples = {} of Person => Hash(Person, Couple))
      with self yield
    end

    def initialize(@persons = {} of String => Person,
                   @graph = GraphViz.new("FamilyTree", use: :neato),
                   @generation_number = 0,
                   @generations = [] of Generation,
                   @couples = {} of Person => Hash(Person, Couple))
    end

    # Add a new generation in the tree
    #
    #   require 'graphviz/family_tree'
    #   t = GraphViz::FamilyTree.new do
    #     generation do
    #       ...
    #     end
    #     generation do
    #       ...
    #     end
    #   end
    def generation(&b)
      gen = GraphViz::FamilyTree::Generation.new(@graph, @persons, self, @generation_number)
      gen.make(&b)
      @generations << gen
      @generation_number += 1
    end

    getter :persons

    def add_couple(x, y, node) # :nodoc:
      @couples[x] = {} of Person => Couple if !@couples.has_key? x
      @couples[x][y] = GraphViz::FamilyTree::Couple.new(@graph, node, [x, y])
      @couples[y] = {} of Person => Couple if !@couples.has_key? y
      @couples[y][x] = @couples[x][y]
    end

    # Get a couple (GraphViz::FamilyTree::Couple)
    def couple(x, y)
      @couples[x][y]
    end

    def method_missing(sym, *args, &block) # :nodoc:
      persons[sym.to_s]
    end

    # Family size
    def size
      @persons.size
    end

    # Get the graph
    def graph
      maxY = @generations.size
      biggestGen, maxX = biggestGenerationNumberAndSize

      puts "#{maxY} generations"
      puts "Plus grosse generation : ##{biggestGen} avec #{maxX} personnes"

      puts "traitement des générations..."

      puts "  #{biggestGen}:"
      @generations[biggestGen].persons.each do |id, person|
        puts "    - #{id} : #{person.class}"
      end

      puts "  Up..."
      (0...biggestGen).reverse_each do |genNumber|
        puts "  #{genNumber}:"
        @generations[genNumber].persons.each do |id, person|
          puts "    - #{id} : #{person.class}"
        end
      end

      puts "  Down..."
      ((biggestGen + 1)...maxY).each do |genNumber|
        puts "  #{genNumber}:"
        @generations[genNumber].persons.each do |id, person|
          puts "    - #{id} : #{person.class}"
        end
      end

      @graph
    end

    private def biggestGenerationNumberAndSize
      size = 0
      number = 0
      @generations.each do |gen|
        if gen.size > size
          size = gen.size
          number = gen.number
        end
      end
      return number, size
    end
  end
end
