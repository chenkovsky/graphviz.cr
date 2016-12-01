class GraphViz
  module Type
    struct GVColorList
      def initialize(@data : Array(GVColor))
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVColor
          return GVColorList.new [a]
        when .is_a? GVColorList
          return a
        when .is_a? String
          return GVColorList.new a.split(":").map { |x| GVColor.gv_parse x }
        when .is_a?(Enumerate(_))
          return GVColorList.new a.map { |x| GVColor.gv_parse x }
        else
          raise ArgumentError.new "#{a} cannot be used as ColorList"
        end
      end
    end
  end
end
