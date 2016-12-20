class GraphViz
  module Type
    struct GVRect
      FLOAT_MASK      = /[-+]?(?:[0-9]*\.[0-9]+|[0-9]+)/
      RECT_FINAL_MASK = /#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/

      def initialize(@data : Array(Float64))
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVRect
          return a
        when .is_a? String
          if a =~ RECT_FINAL_MASK
            return gv_parse a.split(",")
          end
          raise ArgumentError.new "#{a} cannot be used as Rect"
        when .is_a? Array
          if a.size != 4
            raise ArgumentError.new "#{a} cannot be used as Rect"
          end
          return GVRect.new a.map { |x| x.to_f64 }
        else
          raise ArgumentError.new "#{a} cannot be used as Rect"
        end
      end

      def to_gv(io)
        io << @data.join(',')
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
