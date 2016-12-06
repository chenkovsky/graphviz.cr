require "./graphviz/*"

class GraphViz
  @@empty_opts = {} of String => String
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
    add_nodes node_name, opts.size == 0 ? @@empty_opts : opts.to_h
  end

  def add_nodes(node_name : Array(String), opts)
    node_name.each do |name|
      add_node name, opts
    end
  end
end
