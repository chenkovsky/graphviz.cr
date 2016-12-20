class GraphViz
  module Type
    class GVPortPos
      COMPASS_POINT_SET = Set(String).new ["n", "ne", "e", "se", "s", "sw", "w", "nw", "c", "_"]

      def initialize(@port_name : String, @compass_point : String = "_")
      end

      def self.gv_parse(a)
        case a
        when .is_a? GVPortPos
          return a
        when .is_a? String
          if a.includes? ":"
            port_name, compass_point = a.split(":")
            raise ArgumentError.new "#{a} cannot be used as PortPos" unless COMPASS_POINT_SET.includes? compass_point
          else
            port_name, compass_point = a, "_"
          end
          return GVPortPos.new port_name, compass_point
        else
          raise ArgumentError.new "#{a} cannot be used as PortPos"
        end
      end

      def to_gv(io)
        io << @port_name
        io << ':'
        io << @compass_point
      end

      def to_gv
        String.build do |io|
          to_gv io
        end.to_s
      end
    end
  end
end
