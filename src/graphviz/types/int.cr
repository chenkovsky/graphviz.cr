class GraphViz
  module Type
    struct GVInt
      def initialize(@data : Int32)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVInt
          return a
        else
          GVInt.new a.to_i32
        end
      end
    end
  end
end
