class GraphViz
  module Type
    enum GVSmoothType
      None
      Avg_dist
      Graph_dist
      Power_dist
      Rng
      Spring
      Triangle

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a.capitalize
        when .is_a? GVSmoothType
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as SmoothType"
        end
      end

      def to_gv(io)
        io << to_s.inspect
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
