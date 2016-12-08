class GraphViz
  class Edge
    # node_one --> node_two
    @node_one : Node | Tuple(Node, String)
    @node_two : Node | Tuple(Node, String)
    @parent_graph : GraphViz

    def initialize(@node_one, @node_two, @parent_graph)
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

    private def _node_one_s
      if @node_one.is_a? Node
        return escape @node_one.as(Node).id
      else
        node, port = @node_one.as(Tuple(Node, String))
        return "#{escape node.id, force: true}:#{port}"
      end
    end

    private def _node_two_s
      if @node_two.is_a? Node
        return escape @node_two.as(Node).id
      else
        node, port = @node_two.as(Tuple(Node, String))
        return "#{escape node.id, force: true}:#{port}"
      end
    end

    def to_gv(o_graph_type)
      x_link = " -> "
      if o_graph_type == "graph"
        x_link = " -- "
      end
      _node_one = _node_one_s
      if RESERVED_NAMES.has_key?(_node_one)
        _node_one = "_#{node_one}"
      end

      _node_two = _node_two_s
      if RESERVED_NAMES.has_key?(_node_two)
        _node_two = "_#{node_two}"
      end

      return "#{_node_one}#{x_link}#{_node_two}#{x_attr};"
    end
  end
end
