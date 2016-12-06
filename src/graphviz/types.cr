require "xml"
require "./types/*"

class GraphViz
  module Type
    class GVParseException < Exception
      def initialize(@exceptions : Array(Exception))
      end
    end

    class GVMultiParseException < Exception
      def initialize(@rets : Array(GraphVizType))
      end
    end

    alias GraphVizType = GVDouble | GVEscString | GVString | GVArrowType | GVRect | GVColor | GVColorList | GVBool | GVClusterMode | GVDirType | GVAddDouble | GVAddPoint | GVInt | GVPoint | GVLblString | GVPortPos | GVString | GVOutputMode | GVPageDir | GVSplineType | GVQuadType | GVRankType | GVRankDir | GVDoubleList | GVShape | GVSmoothType | GVStartType | GVPointList | GVViewPort
    # GVLayerRange
    # GVLayerList
    # GVPackMode
    private Types = {
      :GVDouble      => GVDouble,
      :GVEscString   => GVEscString,
      :GVString      => GVString,
      :GVArrowType   => GVArrowType,
      :GVRect        => GVRect,
      :GVColor       => GVColor,
      :GVColorList   => GVColorList,
      :GVBool        => GVBool,
      :GVClusterMode => GVClusterMode,
      :GVDirType     => GVDirType,
      :GVAddDouble   => GVAddDouble,
      :GVAddPoint    => GVAddPoint,
      :GVInt         => GVInt,
      :GVPoint       => GVPoint,
      :GVLblString   => GVLblString,
      :GVPortPos     => GVPortPos,
      :GVString      => GVString,
      # :GVLayerRange  => GVLayerRange,
      # :GVLayerList  => GVLayerList,
      :GVOutputMode => GVOutputMode,
      # :GVPackMode   => GVPackMode,
      :GVPageDir    => GVPageDir,
      :GVSplineType => GVSplineType,
      :GVQuadType   => GVQuadType,
      :GVRankType   => GVRankType,
      :GVRankDir    => GVRankDir,
      :GVDoubleList => GVDoubleList,
      :GVShape      => GVShape,
      :GVSmoothType => GVSmoothType,
      :GVStartType  => GVStartType,
      :GVPointList  => GVPointList,
      :GVViewPort   => GVViewPort,
    }

    def self.gv_parse(types, v) : GraphVizType
      errors = [] of Exception
      rets = [] of GraphVizType
      types.each do |t|
        cls = Types[t]
        begin
          rets << cls.gv_parse(v).as(GraphVizType)
        rescue e
          errors << e
        end
      end
      raise GVParseException.new(errors) if rets.size == 0
      raise GVMultiParseException.new(rets) if rets.size > 1
      return rets[0]
    end
  end
end
