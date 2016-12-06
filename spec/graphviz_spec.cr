require "./spec_helper"

describe GraphViz do
  # TODO: Write tests

  it "basic" do
    g = GraphViz.new(:G, type: :digraph)
    # Create two nodes
    hello = g.add_node "Hello"
    world = g.add_node "World"

    # Create an edge between the two nodes
    g.add_edge hello, world

    # Generate output image
    g.output png: "hello_world.png"
  end

  it "with block" do
    GraphViz.new(:G, type: :digraph) { |g|
      g.world(label: "World") << g.hello(label: "Hello")
    }.output(png: "hello_world.png")
  end

  it "dsl" do
    digraph :G do
      world(label: "World") << hello(label: "Hello")
      output png: "hello_world.png"
    end
  end

  it "read dot" do
    GraphViz.parse("hello.dot", path: "/usr/local/bin") { |g|
      g.get_node("Hello") { |n|
        n[:label] = "Bonjour"
      }
      g.get_node("World") { |n|
        n[:label] = "Le Monde"
      }
    }.output(png: "sample.png")
  end
end
