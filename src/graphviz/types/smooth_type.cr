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
