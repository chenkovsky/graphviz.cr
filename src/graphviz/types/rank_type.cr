class GraphViz
  module Type
    enum GVRankType
      Same
      Min
      Source
      Max
      Sink

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a.capitalize
        when .is_a? GVRankType
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as RankType"
        end
      end

      def to_gv
        self.to_s.downcase.inspect.gsub("\\\\", "\\")
      end
    end
  end
end
