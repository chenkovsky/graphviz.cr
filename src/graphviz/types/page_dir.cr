class GraphViz
  module Types
    enum GVPagedir
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
        when .is_a? GVPagedir
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as Pagedir"
        end
      end

      def to_gv
        self.to_s.downcase.inspect.gsub("\\\\", "\\")
      end
    end
  end
end
