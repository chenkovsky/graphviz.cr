class GraphViz
  class Edge
    @node_one_id : Int32
    @node_two_id : Int32
    @node_one_port : Int32?
    @node_two_port : Int32?
    @index : Int32?

    def initialize(v_node_one : Node, v_node_two : Node, @parent_graph : GraphViz)
      @node_one_id, @node_one_port = get_node_name_and_port v_node_one
      @node_two_id, @node_two_port = get_node_name_and_port v_node_two
      @edge_attributes = Attrs.new(nil, "edge", Attrs::E_ATTRS)
      unless @parent_graph.directed?
        (@parent_graph.find_node(@node_one_id) || @parent_graph.add_nodes(@node_one_id)).incidents << (@parent_graph.find_node(@node_two_id) || @parent_graph.add_nodes(@node_two_id))
        (@parent_graph.find_node(@node_two_id) || @parent_graph.add_nodes(@node_two_id)).neighbors << (@parent_graph.find_node(@node_one_id) || @parent_graph.add_nodes(@node_one_id))
      end
      (@parent_graph.find_node(@node_one_id) || @parent_graph.add_nodes(@node_one_id)).neighbors << (@parent_graph.find_node(@node_two_id) || @parent_graph.add_nodes(@node_two_id))
      (@parent_graph.find_node(@node_two_id) || @parent_graph.add_nodes(@node_two_id)).incidents << (@parent_graph.find_node(@node_one_id) || @parent_graph.add_nodes(@node_one_id))
    end

    def node_one(with_port = true, escaped = true)
      if !(!@node_one_port.nil? && with_port)
        escaped ? escape(@node_one_id) : @node_one_id
      else
        escaped ? escape(@node_one_id, force: true) + ":#{@node_one_port}" : "#{@node_one_id}:#{@node_one_port}"
      end
    end

    def tail_node(with_port = true, escaped = true)
      node_one(with_port, escaped)
    end

    def node_two(with_port = true, escaped = true)
      if !(!@node_two_port.nil? && with_port)
        escaped ? escape(@node_two_id) : @node_two_id
      else
        escaped ? escape(@node_two_id, force: true) + ":#{@node_two_port}" : "#{@node_two_id}:#{@node_two_port}"
      end
    end

    def head_node(with_port = true, escaped = true)
      node_two(with_port, escaped)
    end

    getter :index

    def index=(i)
      @index = i if @index.nil?
    end

    def []=(attr_name, attr_value)
      attr_value_ = attr_value.class == Symbol ? attr_value.to_s : attr_value
      @edge_attributes[attr_name.to_s] = attr_value_
    end

    def [](attr_name)
      if @edge_attributes[attr_name.to_s]
        @edge_attributes[attr_name.to_s].clone
      else
        nil
      end
    end

    def each_attribute(global = true)
      attrs = @edge_attributes.to_h
      if global
        attrs = parent_graph.edge.to_h.merge attrs
      end
      attrs.each do |k, v|
        yield k, v
      end
    end

    def <<(node)
      n = @parent_graph.get_node(@node_two_id)
      common_graph(node, n).add_edges(n, node)
    end

    def >(node)
      self << node
    end

    def >>(node)
      node << self
    end

    def root_graph
      pg = parent_graph
      pg.nil? ? nil : pg.root_graph
    end

    getter :parent_graph

    def set
      with self yield
    end

    private RESERVED_NAMES = Set(String).new ["node", "edge", "graph", "digraph", "subgraph", "strict"]

    def to_gv(o_graph_type)
      x_link = " -> "
      if o_graph_type == "graph"
        x_link = " -- "
      end
      _node_one = node_one
      if RESERVED_NAMES.has_key?(_node_one)
        _node_one = "_#{node_one}"
      end

      _node_two = node_two
      if RESERVED_NAMES.has_key?(_node_two)
        _node_two = "_#{node_two}"
      end

      return "#{_node_one}#{x_link}#{_node_two}#{x_attr};"
    end

    private def get_node_name_and_port(node)
      name, port = nil, nil
    end
  end
end
