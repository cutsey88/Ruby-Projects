class Node
  attr_accessor :space, :children
  def initialize(space, children)
    @space = space
    @children = children
  end
end
