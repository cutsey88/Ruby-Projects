require_relative 'node.rb'

class LinkedList
  attr_accessor :size, :head

  def initialize
    @size = 0
    @head = nil
  end

  def append(value)
    if head.nil?
      self.head = Node.new(value)
    else
      traverse(head).next_node = Node.new(value)
    end
    self.size += 1
  end

  def prepend(value)
    if head.nil?
      self.head = Node.new(value)
    else
      self.head = Node.new(value, head)
    end
    self.size += 1
  end

  def tail
    traverse(head)
  end
  
  def traverse(node)
    return node if node.next_node.nil?

    traverse(node.next_node)
  end

  def at(index)
    return 'too big' if index > size
    return head if index == 1
    
    temp = nil
    (index - 1).times do
      if temp.nil?
        temp = head.next_node
      else
        temp = temp.next_node
      end
    end
    temp
  end

  def pop
    at(size - 1).next_node = nil
  end

  def contains?(value)
    temp = nil
    (size - 1).times do
      if temp.nil?
        temp = head.next_node
      else
        temp = temp.next_node
      end
      return true if temp.value == value
    end
    false
  end

  def find(value)
    temp = nil
    (size - 1).times do
      if temp.nil?
        temp = head.next_node
      else
        temp = temp.next_node
      end
      return temp if temp.value == value
    end
    nil
  end

  def to_s
    string = "(#{head.value}) -> "
    temp = nil
    (size - 1).times do
      if temp.nil?
        temp = head.next_node
      else
        temp = temp.next_node
      end
      temp.nil? ? string += 'nil' : string += "(#{temp.value}) -> "
    end
    string
  end

  def insert_at(value, index)
    new_guy = Node.new(value, at(index))
    at(index - 1).next_node = new_guy
  end

  def remove_at(index)
    at(index - 1).next_node = at(index + 1)
  end
end
