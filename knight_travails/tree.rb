require_relative 'node.rb'
require 'pry'

class Tree
  attr_accessor :nodes

  def initialize(array)
    @nodes = create_nodes(array)
  end
  
  def create_nodes(array)
    nodes = []
    array.each do |space|
      nodes << Node.new(space, create_children(array, space))
    end
    nodes
  end

  def create_children(array, space)
    spaces = []
    positions = []
    positions << [(space[0] + 1), (space[1] + 2)]
    positions << [(space[0] + 1), (space[1] - 2)]
    positions << [(space[0] + 2), (space[1] + 1)]
    positions << [(space[0] + 2), (space[1] - 1)]
    positions << [(space[0] - 1), (space[1] - 2)]
    positions << [(space[0] - 1), (space[1] + 2)]
    positions << [(space[0] - 2), (space[1] - 1)]
    positions << [(space[0] - 2), (space[1] + 1)]

    positions.each do |position|
      spaces << position if array.include?(position)
    end
    spaces
  end

  def knight_moves(start, destination)
    flat_path = find_shortest_path(start, destination).flatten
    fixed_path = flat_path.map.with_index do |num, index|
      [num, flat_path[index + 1]] if index.even?
    end
    fixed_path.compact!
    puts <<~HEREDOC
      You made it in #{fixed_path.length - 1} moves! Here's your path:
        #{fixed_path}
    HEREDOC
  end

  def find_shortest_path(start_spot, end_spot, path=[])
    return start_spot if start_spot == end_spot

    queue = []
    hub_queue = []
    position = find_node(start_spot)
    hub = position
    until position.space == end_spot
      position.children.each do |child|
        queue << child
        hub_queue << child
      end
      if position.space == hub.children[-1]
        hub = find_node(hub_queue[0])
        hub_queue.shift
      end
      position = find_node(queue[0])
      queue.shift
    end
    path.unshift(position.space)
    path.unshift(find_shortest_path(start_spot, hub.space))
  end

  def find_node(space)
    node_index = nodes.index { |node| node.space == space}
    nodes[node_index]
  end
end
