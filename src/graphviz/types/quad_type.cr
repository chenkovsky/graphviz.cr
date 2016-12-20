class GraphViz
  module Type
    enum GVQuadType
      Normal
      Fast
      None

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a.capitalize
        when .is_a? GVQuadType
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as QuadType"
        end
      end

      def to_gv(io)
        io << self.to_s.downcase.inspect
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
