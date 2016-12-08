require "./graphviz/*"

class GraphViz
  @nodes : Hash(String, Node)

  def initialize(name : Symbol | String, **opts)
    initialize(name, opts)
    yield self
  end

  def initialize(name : Symbol | String, **opts)
    initialize(name, opts)
  end

  def initialize(name : Symbol | String, opts)
    initialize(name, opts)
    yield self
  end

  def initialize(name : Symbol | String, opts)
    @nodes = Hash(String, Node).new
  end

  def add_node(node_name : String, **opts)
    add_node node_name, opts
  end

  def add_node(node_name : String, options)
    unless @nodes.has_key? node_name
      @nodes[node_name] = node = Node.new(node_name, self)
      unless options.has_key?(:label) || (!options.is_a?(NamedTuple) && options.has_key?("label"))
        node["label"] = node_name
      end
    end
    node = @nodes[node_name]
    options.each do |xkey, xvalue|
      node[xkey.to_s] = xvalue
    end
    return node
  end

  def add_nodes(node_name : Array(String), **opts)
    add_nodes node_name, opts
  end

  def add_nodes(node_name : Array(String), opts)
    node_name.each do |name|
      add_node name, opts
    end
  end

  def add_edge(node_one, node_two, **opts)
    add_edge node_one, node_two, opts
  end

  def add_edge(node_one, node_two, opts)
    edge = Edge.new node_one, node_two, self
    opts.each do |k, v|
      edge[k.to_s] = v
    end
    return edge
  end

  def add_edges(node_one, node_two, **opts)
    add_edges node_one, node_two, opts
  end

  def get_node(name)
    node = @nodes[name]?
    return node
  end

  def get_node(name)
    node = @nodes[name]?
    yield node if node
  end

  def add_edges(node_one : Enumerable(String) | Enumerable(Symbol) | Enumerable(Node) | Node | String | Symbol, node_two : Enumerable(String) | Enumerable(Node) | Node | String | Symbol, opts)
    node_one_ = case node_one
                when .is_a? Enumerable(String)
                  node_one.map { |n| get_node n }
                when .is_a? Enumerable(Symbol)
                  node_one.map { |n| get_node n.to_s }
                when .is_a? Enumerable(Node)
                  node_one
                when .is_a? String
                  {get_node node_one}
                when .is_a? Symbol
                  {get_node node_one.to_s}
                else
                  {node_one}
                end
    node_two_ = case node_two
                when .is_a? Enumerable(String)
                  node_two.map { |n| get_node n }
                when .is_a? Enumerable(Symbol)
                  node_two.map { |n| get_node n.to_s }
                when .is_a? Enumerable(Node)
                  node_two
                when .is_a? String
                  {get_node node_two}
                when .is_a? Symbol
                  {get_node node_two.to_s}
                else
                  {node_two}
                end
    node_one_.product(node_two_) do |n1, n2|
      add_edge n1, n2, opts
    end
  end

  def self.escape(str, **opts)
    escape str, opts
  end

  RESERVED_NAMES = Set(String).new ["node", "edge", "graph", "digraph", "subgraph", "strict"]

  def self.escape(str, opts)
    options = {
      :force         => false,
      :unquote_empty => false,
    }
    opts.each do |k, v|
      options[k] = v
    end

    if options[:force]? || str.match(/\A[a-zA-Z_]+[a-zA-Z0-9_]*\Z/).nil? || RESERVED_NAMES.includes?(str.downcase)
      unless options[:unquote_empty]? && str.size == 0
        '"' + str.gsub('"', %{\\"}).gsub("\n", "\\\\n") + '"'
      end
    else
      str
    end
  end

  def output(**opts)
    output opts
  end

  def output(opts)
  end

  macro method_missing(call)
    add_node {{call.name.id.stringify}} {{call.named_args}}
  end
end
