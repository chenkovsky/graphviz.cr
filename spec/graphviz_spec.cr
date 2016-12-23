require "./spec_helper"

describe GraphViz do
  # TODO: Write tests

  it "basic" do
    g = GraphViz.new(:G, type: :digraph)
    # Create two nodes
    hello = g.add_node "Hello", label: "你好"
    world = g.add_node "World", label: "世界"

    # Create an edge between the two nodes
    edge = g.add_edge hello, world
    edge[:label] = "边"
    g[:label] = "example"

    # Generate output image
    STDERR.puts g.to_s
  end

  # it "with block" do
  #   GraphViz.new(:G, type: :digraph) { |g|
  #     g.world(label: "World") << g.hello(label: "Hello")
  #   }.output(png: "hello_world.png")
  # end

  # it "dsl" do
  #   digraph :G do
  #     world(label: "World") << hello(label: "Hello")
  #     output png: "hello_world.png"
  #   end
  # end
end
