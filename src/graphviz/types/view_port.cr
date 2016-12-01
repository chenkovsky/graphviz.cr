class GraphViz
  module Type
    struct GVViewPort
      FLOAT_MASK = /[-+]?(?:[0-9]*\.[0-9]+|[0-9]+)/

      MATCH_RE = /^#{FLOAT_MASK},#{FLOAT_MASK},#{FLOAT_MASK},(?:#{FLOAT_MASK},#{FLOAT_MASK}|[^,]+)$/

      def initialize(@data : String)
      end

      def self.gz_parse(a)
        case a
        when .is_a? GVViewPort
          return a
        when .is_a? String
          if a =~ MATCH_RE
            return GVViewPort.new a
          end
        end
        raise ArgumentError.new "#{a} cannot be used as ViewPort"
      end
    end
  end
end
