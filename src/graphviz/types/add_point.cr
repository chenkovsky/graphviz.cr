class GraphViz
  module Type
    struct GVAddPoint
      def initialize(@data : GVPoint, @signed : Bool = false)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVAddPoint
          return a
        when .is_a? GVPoint
          return GVAddPoint.new a
        when .is_a? String
          if a[0] == '+'
            return GVAddPoint.new GVPoint.gv_parse(a[1, a.size - 1]), true
          else
            return GVAddPoint.new GVPoint.gv_parse(a)
          end
        else
          raise ArgumentError.new "#{a} cannot be used as AddPoint"
        end
      end
    end
  end
end
