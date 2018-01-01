class GraphViz
  module Type
    struct GVEscString
      def initialize(@data : String)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVEscString
          return a
        else
          return GVEscString.new a.to_s
        end
      end

      def to_gv
        self.inspect.gsub("\\\\", "\\")
      end
    end

    struct GVString
      def initialize(@data : String)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVString
          return a
        else
          return GVString.new a.to_s
        end
      end

      def to_gv
        @data.inspect.gsub("\\\\", "\\")
      end
    end

    struct GVLblString
      def initialize(@data : String)
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVLblString
          return a
        when .is_a? String
          return GVLblString.new a
        else
          raise ArgumentError.new "#{a} cannot be used as LblString"
        end
      end

      def to_gv(io)
        html = /^<(.*)>$/m.match(@data)
        if !html.nil?
          xml = "<gv>" + html[1].to_s + "</gv>"
          begin
            doc = XML.parse xml
            unless doc.text == html[1].to_s
              "<#{html[1]}>"
            else
              io << @data.inspect.gsub("\\\\", "\\")
            end
          rescue e
            io << @data.inspect.gsub("\\\\", "\\")
          end
        else
          io << @data.inspect.gsub("\\\\", "\\")
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
