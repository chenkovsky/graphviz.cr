class GraphViz
  module Type
    struct GVDoubleList
      def initialize(@data : Array(GVDouble))
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVDoubleList
          return a
        when .is_a? Array(GVDouble)
          return GVDoubleList.new a
        when .is_a? Enumerable
          return GVDoubleList.new a.map { |x| GVDouble.gv_parse x }
        else
          raise ArgumentError.new "#{a} cannot be used as DoubleList"
        end
      end

      def to_gv(io)
        @data[0].to_gv io
        (1...@data.size).each do |idx|
          io << ':'
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
