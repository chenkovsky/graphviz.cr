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

      def to_gv
        self.to_s.downcase.inspect.gsub("\\\\", "\\")
      end
    end
  end
end
