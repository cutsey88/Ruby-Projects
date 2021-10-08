class Node
  include Comparable

  attr_accessor :data, :left_child, :right_child

  def <=>(other)
    if other.is_a?(Node)
      data <=> other.data
    else
      data <=> other
    end
  end

  def initialize(data, left_child=nil, right_child=nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end
