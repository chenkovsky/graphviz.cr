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

      def to_gv(io)
        io << @data
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
