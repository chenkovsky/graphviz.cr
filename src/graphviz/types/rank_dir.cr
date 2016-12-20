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
