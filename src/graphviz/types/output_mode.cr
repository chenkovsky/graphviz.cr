class GraphViz
  module Type
    enum GVOutputMode
      Breadthfirst
      Nodesfirst
      Edgesfirst

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a.capitalize
        when .is_a? GVOutputMode
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as OutputMode"
        end
      end
    end
  end
end
