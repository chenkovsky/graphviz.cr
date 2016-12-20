class GraphViz
  module Type
    enum GVPageDir
      BL
      BR
      TL
      TR
      RB
      LB
      LT

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a
        when .is_a? GVPageDir
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as Pagedir"
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
