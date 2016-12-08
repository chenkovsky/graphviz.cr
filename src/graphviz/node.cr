class GraphViz
  class Node
    getter :neighbors, :incidents

    def initialize(@node_id : String, @parent_graph : GraphViz)
      @neighbors = [] of Node
      @incidents = [] of Node
      @node_attributes = Attrs.new(nil, "node", Attrs::N_ATTRS)
    end

    def id
      @node_id.clone
    end

    def root_graph
      pg = parent_graph
      pg.nil? ? nil : pg.root_graph
    end

    def []=(attr_name : String | Symbol, attr_value)
      @node_attributes[attr_name] = attr_value
    end

    def [](attr_name : String | Symbol)
      val = @node_attributes[attr_name.to_s]
      val.nil? ? nil : val.clone
    end

    def each_attribute(global = true)
      attrs = @node_attributes.to_h
      if global
        attrs = parent_graph.node.to_h.merge attrs
      end
      attrs.each do |k, v|
        yield k, v
      end
    end

    # Create an edge between the current node and the node +node+
    def <<(node)
      if node.is_a? Enumerable(T)
        node.each do |n|
          self << n
        end
      else
        return common_graph(node, self).add_edges(self, node)
      end
    end

    def <(node)
      self << node
    end

    def >>(node)
      node << self
    end

    def set
      with self yield
    end

    getter :parent_graph

    def to_gv
      node_id = escape @node_id
      node_id = RESERVED_NAMES.includes?(node_id) ? "_#{node_id}" : node_id
      if @node_attributes.data.has_key?("label") && @node_attributes.data.has_key?("html")
        @node_attributes.data.delete("label")
      end
      x_attr = @node_attributes.data.map { |k, v| "#{k} = #{v.to_gv}" }.join(",")
      return "#{node_id}[#{x_attr}];"
    end
  end
end
