class GraphViz
  class Attrs
    class AttributeException < Exception
    end

    ATTRS = [
      {:Damping, "G", [:GVDouble]},
      {:K, "GC", [:GVDouble]},
      {:URL, "ENGC", [:GVEscString]},
      {:_background, "G", [:GVString]},
      {:area, "NC", [:GVDouble]},
      {:arrowhead, "E", [:GVArrowType]},
      {:arrowsize, "E", [:GVDouble]},
      {:arowtail, "E", [:GVArrowType]},
      {:bb, "G", [:GVRect]},
      {:bgcolor, "GC", [:GVColorList]},
      {:center, "G", [:GVBool]},
      {:charset, "G", [:GVString]},
      {:clusterrank, "G", [:GVClusterMode]},
      {:color, "ENC", [:GVColorList]},
      {:colorscheme, "ENCG", [:GVString]},
      {:comment, "ENG", [:GVString]},
      {:compound, "G", [:GVBool]},
      {:concentrate, "G", [:GVBool]},
      {:constraint, "E", [:GVBool]},
      {:decorate, "E", [:GVBool]},
      {:defaultdist, "G", [:GVDouble]},
      {:dim, "G", [:GVInt]},
      {:dimen, "G", [:GVInt]},
      {:dir, "E", [:DirType]},
      {:diredgeconstraints, "G", [:GVString, :GVBool]},
      {:distortion, "N", [:GVDouble]},
      {:dpi, "G", [:GVDouble]},
      {:edgeURL, "E", [:GVEscString]},
      {:edgehref, "E", [:GVEscString]},
      {:edgetarget, "E", [:GVEscString]},
      {:edgetooltip, "E", [:GVEscString]},
      {:epsilon, "G", [:GVDouble]},
      {:esep, "G", [:GVAddDouble, :GVAddPoint]},
      {:fillcolor, "NEC", [:GVColorList]},
      {:fixedsize, "N", [:GVBool, :GVString]},
      {:fontcolor, "ENGC", [:GVColor]},
      {:fontname, "ENGC", [:GVString]},
      {:fontnames, "G", [:GVString]},
      {:fontpath, "G", [:GVString]},
      {:fontsize, "ENGC", [:GVDouble]},
      {:forcelabels, "G", [:GVBool]},
      {:gradientangle, "NCG", [:GVInt]},
      {:group, "N", [:GVString]},
      {:headURL, "E", [:GVEscString]},
      {:head_lp, "E", [:GVPoint]},
      {:headclip, "E", [:GVBool]},
      {:headhref, "E", [:GVEscString]},
      {:headlabel, "E", [:GVLblString]},
      {:headport, "E", [:GVPortPos]},
      {:headtarget, "E", [:GVEscString]},
      {:headtooltip, "E", [:GVEscString]},
      {:height, "N", [:GVDouble]},
      {:href, "GCNE", [:GVEscString]},
      {:id, "GCNE", [:GVEscString]},
      {:image, "N", [:GVString]},
      {:imagepath, "G", [:GVString]},
      {:imagescale, "N", [:GVBool, :String]},
      {:inputscale, "G", [:GVDouble]},
      {:label, "ENGC", [:GVLblString]},
      {:labelURL, "E", [:GVEscString]},
      {:label_scheme, "G", [:GVInt]},
      {:labelangle, "E", [:GVDouble]},
      {:labeldistance, "E", [:GVDouble]},
      {:labelfloat, "E", [:GVBool]},
      {:labelfontcolor, "E", [:GVColor]},
      {:labelfontname, "E", [:GVString]},
      {:labelfontsize, "E", [:GVDouble]},
      {:labelhref, "E", [:GVEscString]},
      {:labeljust, "GC", [:GVString]},
      {:labelloc, "NGC", [:GVString]},
      {:labeltarget, "E", [:GVEscString]},
      {:labeltooltip, "E", [:GVEscString]},
      {:landscape, "G", [:GVBool]},
      {:layer, "ENC", [:GVEscString]},
      {:layerlistsep, "G", [:GVEscString]},
      {:layers, "G", [:GVEscString]},
      {:layerselect, "G", [:GVEscString]},
      {:layersep, "G", [:GVString]},
      {:layout, "G", [:GVString]},
      {:len, "E", [:GVDouble]},
      {:levels, "G", [:GVInt]},
      {:levelsgap, "G", [:GVDouble]},
      {:lhead, "E", [:GVString]},
      {:lheight, "GC", [:GVDouble]},
      {:lp, "EGC", [:GVPoint]},
      {:ltail, "E", [:GVString]},
      {:lwidth, "GC", [:GVDouble]},
      {:margin, "NCG", [:GVDouble, :GVPoint]},
      {:maxiter, "G", [:GVInt]},
      {:mclimit, "G", [:GVDouble]},
      {:mindist, "G", [:GVDouble]},
      {:minlen, "E", [:GVInt]},
      {:mode, "G", [:GVString]},
      {:model, "G", [:GVString]},
      {:mosek, "G", [:GVBool]},
      {:nodesep, "G", [:GVDouble]},
      {:nojustify, "GCNE", [:GVBool]},
      {:normalize, "G", [:GVDouble, :GVBool]},
      {:notranslate, "G", [:GVBool]},
      {:nslimit, "G", [:GVDouble]},
      {:nslimit1, "G", [:GVDouble]},
      {:ordering, "GN", [:GVString]},
      {:orientation, "N", [:GVDouble]},
      {:orientation, "G", [:GVString]},
      {:outputorder, "G", [:GVOutputMode]},
      {:overlap, "G", [:GVString, :GVBool]},
      {:overlap_scaling, "G", [:GVDouble]},
      {:overlap_shrink, "G", [:GVBool]},
      {:pack, "G", [:GVBool, :GVInt]},
      {:packmode, "G", [:EscString]},
      {:pad, "G", [:GVDouble, :GVPoint]},
      {:page, "G", [:GVDouble, :GVPoint]},
      {:pagedir, "G", [:GVPagedir]},
      {:pencolor, "C", [:GVColor]},
      {:penwidth, "CNE", [:GVDouble]},
      {:peripheries, "NC", [:GVInt]},
      {:pin, "N", [:GVBool]},
      {:pos, "EN", [:GVPoint, :GVSplineType]},
      {:quadtree, "G", [:GVQuadType, :GVBool]},
      {:quantum, "G", [:GVDouble]},
      {:rank, "S", [:GVRankType]},
      {:rankdir, "G", [:GVRankdir]},
      {:ranksep, "G", [:GVDouble, :GVDoubleList]},
      {:ratio, "G", [:GVDouble, :GVString]},
      {:rects, "N", [:GVRect]},
      {:regular, "N", [:GVBool]},
      {:remincross, "G", [:GVBool]},
      {:repulsiveforce, "G", [:GVDouble]},
      {:resolution, "G", [:GVDouble]},
      {:root, "GN", [:GVString, :GVBool]},
      {:rotate, "G", [:GVInt]},
      {:rotation, "G", [:GVDouble]},
      {:samehead, "E", [:GVString]},
      {:sametail, "E", [:GVString]},
      {:samplepoints, "N", [:GVInt]},
      {:scale, "G", [:GVDouble, :GVPoint]},
      {:searchsize, "G", [:GVInt]},
      {:sep, "G", [:GVAddDouble, :GVAddPoint]},
      {:shape, "N", [:GVShape]},
      {:shapefile, "N", [:GVString]},
      {:showboxes, "ENG", [:GVInt]},
      {:sides, "N", [:GVInt]},
      {:size, "G", [:GVDouble, :GVPoint]},
      {:skew, "N", [:GVDouble]},
      {:smoothing, "G", [:GVSmoothType]},
      {:sortv, "GCN", [:GVInt]},
      {:splines, "G", [:GVBool, :GVString]},
      {:start, "G", [:GVStartType]},
      {:style, "ENCG", [:GVEscString]},
      {:stylesheet, "G", [:GVString]},
      {:tailURL, "E", [:GVEscString]},
      {:tail_lp, "E", [:GVPoint]},
      {:tailclip, "E", [:GVBool]},
      {:tailhref, "E", [:GVEscString]},
      {:taillabel, "E", [:GVLblString]},
      {:tailport, "E", [:GVPortPos]},
      {:tailtarget, "E", [:GVEscString]},
      {:tailtooltip, "E", [:GVEscString]},
      {:target, "ENGC", [:GVEscString, :GVString]},
      {:tooltip, "NEC", [:GVEscString]},
      {:truecolor, "G", [:GVBool]},
      {:vertices, "N", [:GVPointList]},
      {:viewport, "G", [:GVViewPort]},
      {:voro_margin, "G", [:GVDouble]},
      {:weight, "E", [:GVInt, :GVDouble]},
      {:width, "N", [:GVDouble]},
      {:xdotversion, "G", [:GVString]},
      {:xlabel, "EN", [:GVLblString]},
      {:xlp, "NE", [:GVPoint]},
      {:z, "N", [:GVDouble]},
    ]
    G_ATTRS = Hash(String, Array(Symbol)).new
    E_ATTRS = Hash(String, Array(Symbol)).new
    N_ATTRS = Hash(String, Array(Symbol)).new
    C_ATTRS = Hash(String, Array(Symbol)).new
    ATTRS.each do |name, used_by, typ|
      G_ATTRS[name.to_s] = typ
      E_ATTRS[name.to_s] = typ
      N_ATTRS[name.to_s] = typ
      C_ATTRS[name.to_s] = typ
    end

    getter :data
    @graphviz : GraphViz?
    @name : String
    @attributes : Hash(String, Array(Symbol))

    def initialize(@graphviz, @name, @attributes)
      @data = Hash(String, Type::GraphVizType).new
    end

    delegate :each, to: @data

    def to_h
      @data.clone
    end

    def [](key : String) : GraphViz
      @data[key]
    end

    def []=(key : String, value)
      unless @attributes.has_key? key
        raise ArgumentError.new "#{@name} attribute '#{key}' invalid"
      end
      @data[key] = Type.gv_parse @attributes[key], value
    end
  end
end
