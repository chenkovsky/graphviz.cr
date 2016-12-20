class GraphViz
  module Type
    enum GVArrowType
      Normal
      Inv
      Dot
      Invdot
      Odot
      Invodot
      None
      Tee
      Empty
      Invempty
      Diamond
      Odiamond
      Ediamond
      Crow
      Box
      Obox
      Open
      Halfopen
      Vee
      Circle

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a.capitalize
        when .is_a? GVArrowType
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as ArrowType"
        end
      end

      def to_gv(io)
        io << to_s.downcase.inspect
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
