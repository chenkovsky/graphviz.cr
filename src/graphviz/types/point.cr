class GraphViz
  module Type
    struct GVPoint
      alias Dim2 = {Float64, Float64}
      alias Dim3 = {Float64, Float64, Float64}

      def initialize(@data : Dim2 | Dim3, @fix_possition = false)
      end

      def self.gv_parse(a, fix_possition = false)
        case a
        when .is_a? GVPoint
          return a
        when .is_a? Enumerable
          data = a.map { |x| x.to_f64 }
          case data.size
          when 2
            return GVPoint.new ({data[0], data[1]}), fix_possition
          when 3
            return GVPoint.new ({data[0], data[1], data[2]}), fix_possition
          else
            raise ArgumentError.new "#{a} cannot be used as Point"
          end
        when .is_a? String
          fix_possition = a[-1] == "!"
          if fix_possition
            a = a[0, a.size - 1]
          end
          return gv_parse a.split(","), fix_possition
        else
          raise ArgumentError.new "#{a} cannot be used as Point"
        end
      end

      def to_gv(io)
        io << @data.join(',')
        if @fix_possition
          io << '!'
        end
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
