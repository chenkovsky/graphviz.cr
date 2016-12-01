class GraphViz
  module Type
    struct GVDouble
      def initialize(@data : Float64)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVDouble
          return a
        else
          GVDouble.new a.to_f64
        end
      end
    end
  end
end
