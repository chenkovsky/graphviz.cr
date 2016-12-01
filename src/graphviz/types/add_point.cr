class GraphViz
  module Type
    struct AddPoint
      def initialize(@data : Point, @signed : Bool = false)
      end

      def self.gv_parse(a)
        case a
        when .is_a? AddPoint
          return a
        when .is_a? Point
          return AddPoint.new a
        when .is_a? String
          if a[0] == '+'
            return AddPoint.new Point.gv_parse(a[1, a.size - 1]), true
          else
            return AddPoint.new Point.gv_parse(a)
          end
        else
          raise ArgumentError.new "#{a} cannot be used as AddPoint"
        end
      end
    end
  end
end
