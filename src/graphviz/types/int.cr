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

      def to_gv(io)
        io << @data
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
