class GraphViz
  module Type
    struct GVBool
      BOOL_TRUE  = ["true", "yes"]
      BOOL_FALSE = ["false", "no", ""]

      def initialize(@data : Bool)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVBool
          return a
        when .is_a? Bool
          return GVBool.new a
        when .is_a? String
          is_true = BOOL_TRUE.includes? a
          is_false = BOOL_FALSE.includes? a
          raise ArgumentError.new "#{a} cannot be used as Bool" unless is_true || is_false
        when .is_a? Nil
          return GVBool.new false
        else
          raise ArgumentError.new "#{a} cannot be used as Bool"
        end
      end
    end
  end
end
