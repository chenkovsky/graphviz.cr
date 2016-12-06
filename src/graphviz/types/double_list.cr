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
    end
  end
end
