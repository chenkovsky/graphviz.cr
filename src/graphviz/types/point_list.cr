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

      def to_gv(io)
        @data[0].to_gv io
        (1...@data.size).each do |idx|
          io << ' '
          @data[idx].to_gv io
        end
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
