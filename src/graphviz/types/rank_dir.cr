class GraphViz
  module Type
    enum GVRankDir
      TB
      LR
      BT
      RL

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a
        when .is_a? GVRankDir
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as RankDir"
        end
      end

      def to_gv
        self.to_s.downcase.inspect.gsub("\\\\", "\\")
      end
    end
  end
end
