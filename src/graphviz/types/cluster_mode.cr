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
    end
  end
end
