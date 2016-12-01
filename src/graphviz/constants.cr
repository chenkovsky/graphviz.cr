# Constants for ruby-graphviz
#
# GraphViz::Constants::FORMATS: the possible output formats
#   "bmp", "canon", "dot", "xdot", "cmap", "dia", "eps",
#   "fig", "gd", "gd2", "gif", "gtk", "hpgl", "ico", "imap",
#   "cmapx", "imap_np", "cmapx_np", "ismap", "jpeg", "jpg",
#   "jpe", "mif", "mp", "pcl", "pdf", "pic", "plain",
#   "plain-ext", "png", "ps", "ps2", "svg", "svgz", "tga",
#   "tiff", "tif", "vml", "vmlz", "vrml", "vtx", "wbmp",
#   "xlib", "none"
#
# GraphViz::Constants::PROGRAMS: The possible programs
#   "dot", "neato", "twopi", "fdp", "circo"
#
# GraphViz::Constants::GRAPHTYPE The possible types of graph
#   "digraph", "graph"
#
#
# The single letter codes used in constructors map as follows:
#   G => The root graph, with GRAPHATTRS
#   E => Edge, with EDGESATTRS
#   N => Node, with NODESATTRS
#   S => subgraph
#   C => cluster
#
class GraphViz
  module Constants
    # # Const: Output formats
    FORMATS = [
      "bmp",
      "canon",
      "dot",
      "xdot",
      "cmap",
      "dia",
      "eps",
      "fig",
      "gd",
      "gd2",
      "gif",
      "gtk",
      "hpgl",
      "ico",
      "imap",
      "cmapx",
      "imap_np",
      "cmapx_np",
      "ismap",
      "jpeg",
      "jpg",
      "jpe",
      "mif",
      "mp",
      "pcl",
      "pdf",
      "pic",
      "plain",
      "plain-ext",
      "png",
      "ps",
      "ps2",
      "svg",
      "svgz",
      "tga",
      "tiff",
      "tif",
      "vml",
      "vmlz",
      "vrml",
      "vtx",
      "wbmp",
      "xlib",
      "none",
    ]

    # # Const: programs
    PROGRAMS = [
      "dot",
      "neato",
      "twopi",
      "fdp",
      "circo",
      "sfdp",
    ]

    # # Const: graphs type
    GRAPHTYPE = [
      "digraph",
      "graph",
      "strict digraph",
    ]
  end
end
