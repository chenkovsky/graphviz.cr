class GraphViz
  module Type
    struct GVStartType
      enum Style
        Regular
        Self
        Random
      end

      RE = /(regular|self|random)?(\d+)?/

      def initialize(@style : Style, @seed : String)
      end

      def gz_parse(a)
        case a
        when .is_a? GVStartType
          return a
        when .is_a? String
          m = RE.match a
          GVStartType.new Style.parse(m[1]), m[2]
        end
        raise ArgumentError.new "#{a} cannot be used as GVStartType"
      end
    end
  end
end
