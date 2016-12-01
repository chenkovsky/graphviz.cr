class GraphViz
  module Type
    class GVShape
      Box
      Polygon
      Ellipse
      Oval
      Circle
      Point
      Egg
      Triangle
      Plaintext
      Plain
      Diamond
      Trapezium
      Parallelogram
      House
      Pentagon
      Hexagon
      Septagon
      Octagon
      Doublecircle
      Doubleoctagon
      Tripleoctagon
      Invtriangle
      Invtrapezium
      Invhouse
      Mdiamond
      Msquare
      Mcircle
      Rect
      Rectangle
      Square
      Star
      None
      Underline
      Cylinder
      Note
      Tab
      Folder
      Box3d
      Component
      Promoter
      Cds
      Terminator
      Utr
      Primersite
      Restrictionsite
      Fivepoverhang
      Threepoverhang
      Noverhang
      Assembly
      Signature
      Insulator
      Ribosite
      Rnastab
      Proteasesite
      Proteinstab
      Rpromoter
      Rarrow
      Larrow
      Lpromoter
      Record

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a.capitalize
        when .is_a? GVShape
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as Shape"
        end
      end

      def to_gv
        ret = self.to_s
        unless self == Mdiamond || self == Msquare || self == Mcircle
          self.to_s.downcase
        end
        ret.inspect.gsub("\\\\", "\\")
      end
    end
  end
end
