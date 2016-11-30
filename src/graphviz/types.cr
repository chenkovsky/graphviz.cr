require "xml"

class GraphViz
  module Type
    alias GraphVizType = ArrowType | Color | ColorList | EscString | HtmlString | LblString | Rect | SplineType
    enum ArrowType
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

      def output
        self.to_s.downcase.inspect.gsub("\\\\", "\\")
      end

      def to_gv
        output
      end

      def to_s
        output
      end
    end

    class Color
      class ColorException < Exception
      end

      @data : String | Array(Float32)

      def initialize(data : String | Array(Float32))
        @data = check(data)
      end

      HEX_FOR_COLOR = /[0-9a-fA-F]{2}/
      RGBA          = /^#(#{HEX_FOR_COLOR})(#{HEX_FOR_COLOR})(#{HEX_FOR_COLOR})(#{HEX_FOR_COLOR})?$/

      private def check(data : String | Array(Float32))
        case data
        when .is_a? String
          raise ColorException.new "Wrong color definition #{data}" if data.size == 0
          if data[0] == '#'
            if m =~ RGBA
              return data
            end
            raise ColorException.new "Wrong color definition RGBA #{data}"
          elsif data.includes?(",") || data.includes? " "
            m = data.split(/(?:\s*,\s*|\s+)/).map { |x| x.to_f }
            if m.size == 3 && m.all? { |x| x >= 0.0 && x <= 1.0 }
              return data
            end
            raise ColorException.new "Wrong color definition HSV #{data}"
          elsif COLOR_NAMES.has_key? data
            return data
          else
            raise ColorException.new "Wrong color definition String #{data}"
          end
        when .is_a? Array(Float32)
          if data.all? { |x| x >= 0.0 && x <= 1.0 }
            return data
          end
          raise ColorException.new "Wrong color definition HSV #{data}"
        end
      end

      def output
        return @data.to_s.inspect.gsub("\\\\", "\\")
      end

      def to_gv
        output
      end

      def to_s
        output
      end

      def to_ruby
        @to_ruby
      end
    end
  end

  class ColorList < Type
    @data : Array(Color)

    def initialize(data : String)
      @data = check data
    end

    private def check(data : String)
      return data.split(/\s*:\s*/).map { |c| Color.new c }
    end

    def output
      return @data.to_s.inspect.gsub("\\\\", "\\")
    end

    def to_gv
      output
    end

    def to_s
      output
    end
  end

  class EscString < Type
    def initialize(@data : String)
    end

    def output
      return @data.to_s.inspect.gsub("\\\\", "\\")
    end

    def to_gv
      output
    end

    def to_s
      output
    end
  end

  class HtmlString
    def initialize(@data : String)
    end

    def output
      return "<" + @data + ">"
    end

    def to_gv
      output
    end

    def to_s
      output
    end
  end

  class LblString
    def initialize(@data : String)
    end

    def output
      html = /^<(.*)>$/m.match(@data)
      if !html.nil?
        xml = "<gv>" + html[1].to_s + "</gv>"
        begin
          doc = XML.parse xml
          unless doc.text == html[1].to_s
            "<#{html[1]}>"
          else
            @data.to_s.inspect.gsub("\\\\", "\\")
          end
        rescue e
          @data.to_s.inspect.gsub("\\\\", "\\")
        end
      else
        @data.to_s.inspect.gsub("\\\\", "\\")
      end
    end

    def to_gv
      output
    end

    def to_s
      output
    end
  end

  class Rect
    class RectException < Exception
    end

    @data : String

    def initialize(data : String | Array(String))
      @data = check data
    end

    FLOAT_MASK      = /[-+]?(?:[0-9]*\.[0-9]+|[0-9]+)/
    RECT_FINAL_MASK = /#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/

    def check(data : String | Array(String))
      if data.is_a?(String) && RECT_FINAL_MASK.match(data)
        return data
      end
      if data.is_a?(Array(String))
        return check(data.join(","))
      end
      raise RectException.new "Invalid rect value"
    end

    def output
      return @data.inspect.gsub("\\\\", "\\")
    end

    def to_gv
      output
    end

    def to_s
      output
    end
  end

  # spliteType or point
  #
  # spline ( ';' spline )*
  # where spline =  (endp)? (startp)? point (triple)+
  # and triple   =  point point point
  # and endp  =  "e,%f,%f"
  # and startp   =  "s,%f,%f"
  #
  # If a spline has points p1 p2 p3 ... pn, (n = 1 (mod 3)), the points correspond
  # to the control points of a B-spline from p1 to pn. If startp is given, it touches
  # one node of the edge, and the arrowhead goes from p1 to startp. If startp is not
  # given, p1 touches a node. Similarly for pn and endp.
  class SplineType
    class SplineTypeException < Exception
    end

    @data : String

    def initialize(data : String)
      @is_spline = false
      @data = check data
    end

    FLOAT_MASK  = /[-+]?(?:[0-9]*\.[0-9]+|[0-9]+)/
    ENDP_MASK   = /e\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/
    STARTP_MASK = /s\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/
    POINT_MASK  = /#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}(?:\s*,\s*#{FLOAT_MASK})?!?/
    TRIPLE_MASK = /#{POINT_MASK}\s+#{POINT_MASK}\s+#{POINT_MASK}/
    SPLINE_MASK = /(?:#{ENDP_MASK}\s+)?(?:#{STARTP_MASK}\s+)?#{POINT_MASK}(?:\s*#{TRIPLE_MASK})+/

    FINAL_SPLINE_MASK = /^#{SPLINE_MASK}(?:\s*;\s*#{SPLINE_MASK})*$/
    FINAL_POINT_MASK  = /^#{POINT_MASK}$/

    def check(data : String)
      unless SPLINE_MASK.match(data).nil?
        @is_spline = true
        return data
      end
      unless FINAL_POINT_MASK.match(data).nil?
        @is_spline = false
        return data
      end
      raise SplineTypeException.new "Invalid spline type value"
    end

    def output
      return @data.inspect.gsub("\\\\", "\\")
    end

    def to_gv
      output
    end

    def to_s
      output
    end
  end
end
