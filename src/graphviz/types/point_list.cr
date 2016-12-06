class GraphViz
  module Type
    struct GVPointList
      def initialize(@data : Array(GVPoint))
      end

      def self.gv_parse(a)
        case a
        when .is_a? String
          GVPointList.new a.split(" ").map { |x| GVPoint.gv_parse x }
        when .is_a? Enumerable(String)
          GVPointList.new a.map { |x| GVPoint.gv_parse x }
        when .is_a? Enumerable(GVPoint)
          GVPointList.new a.to_a
        else
          raise ArgumentError.new "#{a} cannot be used as PointList"
        end
      end
    end
  end
end
