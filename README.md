# graphviz

Generate graphviz dot file with crystal

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  graphviz:
    github: chenkovsky/graphviz.cr
```


## Usage


```crystal
require "graphviz"

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
```


TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/chenkovsky/graphviz.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [chenkovsky](https://github.com/chenkovsky) chenkovsky - creator, maintainer
