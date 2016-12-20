class GraphViz
  module Type
    struct GVSplineType
      class SplineTypeException < Exception
      end

      def initialize(@data : String, @is_spline = false)
      end

      FLOAT_MASK  = /[-+]?(?:[0-9]*\.[0-9]+|[0-9]+)/
      ENDP_MASK   = /e\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/
      STARTP_MASK = /s\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/
      POINT_MASK  = /#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}(?:\s*,\s*#{FLOAT_MASK})?!?/
      TRIPLE_MASK = /#{POINT_MASK}\s+#{POINT_MASK}\s+#{POINT_MASK}/
      SPLINE_MASK = /(?:#{ENDP_MASK}\s+)?(?:#{STARTP_MASK}\s+)?#{POINT_MASK}(?:\s*#{TRIPLE_MASK})+/

      FINAL_SPLINE_MASK = /^#{SPLINE_MASK}(?:\s*;\s*#{SPLINE_MASK})*$/
      FINAL_POINT_MASK  = /^#{POINT_MASK}$/

      def self.gv_parse(a)
        case a
        when .is_a? GVSplineType
          return a
        when .is_a? String
          unless SPLINE_MASK.match(a).nil?
            return GVSplineType.new a, true
          end
          unless FINAL_POINT_MASK.match(a).nil?
            return GVSplineType.new a, false
          end
        end
        raise ArgumentError.new "Invalid spline type value #{a}"
      end

      def to_gv(io)
        io << @data.inspect.gsub("\\\\", "\\")
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
