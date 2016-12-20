class GraphViz
  module Type
    enum GVClusterMode
      Local
      Global
      None

      def self.gv_parse(a)
        case a
        when .is_a? String
          parse a.capitalize
        when .is_a? GVClusterMode
          return a
        else
          raise ArgumentError.new "#{a} cannot be used as ClusterMode"
        end
      end

      def to_gv(io)
        io << to_s.downcase.inspect # .gsub("\\\\", "\\")
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
