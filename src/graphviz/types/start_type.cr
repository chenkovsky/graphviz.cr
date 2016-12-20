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

      def self.gv_parse(a)
        case a
        when .is_a? GVStartType
          return a
        when .is_a? String
          m = RE.match a
          if m.nil?
            raise ArgumentError.new "#{a} cannot be used as GVStartType"
          end
          GVStartType.new Style.parse(m[1]), m[2]
        end
        raise ArgumentError.new "#{a} cannot be used as GVStartType"
      end

      def to_gv(io)
        io << @style.to_s.downcase
        io << @seed
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
