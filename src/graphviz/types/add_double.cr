class GraphViz
  module Type
    struct GVAddDouble
      def initialize(@data : Float64, @signed : Bool = false)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVAddDouble
          return a
        when .is_a? Number
          return GVAddDouble.new a.to_f64
        when .is_a? String
          return GVAddDouble.new a.to_f64, a[0] == '+'
        else
          raise ArgumentError.new "#{a} cannot be used as AddDouble"
        end
      end

      def to_gv(io)
        if @signed
          io << '+'
        end
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
