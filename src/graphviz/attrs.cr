class GraphViz
  class Attrs
    class AttributeException < Exception
    end

    getter :data
    @graphviz : GraphViz?
    @name : String
    @attributes : Hash(String, Symbol)

    def initialize(@graphviz, @name, @attributes)
      @name = name
      @data = Hash(String, GraphVizType).new
    end

    delegate :each, to: @data

    def to_h
      @data.clone
    end

    def [](key : String)
      @data[key]
    end

    def []=(key : String, value : GraphVizType)
      unless @attributes.includes?(key)
        raise ArgumentError, "#{@name} attribute '#{key}' invalid"
      end
      @data[key] = value
      gz = @graphviz
      gz.set_position(@name, key, @data[key]) if gz
    end
  end
end
