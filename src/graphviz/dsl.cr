class GraphViz
  class DSL
    def initialize(name, **options)
      @graph = GraphViz.new(name, options.to_h)
      with self yield
    end

    def n(name)
      return @graph.get_node(name) unless @graph.get_node(name).nil?
      @graph.add_nodes(name)
    end

    def e(*args)
      last_e = nil
      (1...args.size).each do |idx|
        last_e = @graph.add_edges args[idx - 1], args[idx]
      end
      last_e
    end

    def subgraph(name)
      dsl = DSL.new(name, parent: @graph, type: @graph.type)
      with dsl yield
      @graph.add_graph(dsl.graph)
    end

    def cluster(name)
      subgraph name
    end

    def output(**options)
      @graph.output options.to_h
    end
  end

  def self.graph(name, **options)
    options_h = options.to_h
    options_h[:type] = "graph"
    dsl = DSL.new(name, options_h)
    with dsl yield
    dsl.graph
  end

  def self.digraph(name, **options)
    options_h = options.to_h
    options_h[:type] = "digraph"
    dsl = DSL.new(name, options_h)
    with dsl yield
    dsl.graph
  end

  def self.strict(name, **options)
    options_h = options.to_h
    options_h[:type] = "strict digraph"
    dsl = DSL.new(name, options_h)
    with dsl yield
    dsl.graph
  end
end
