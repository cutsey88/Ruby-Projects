require_relative 'node.rb'

class Tree
  attr_accessor :root
  def initialize(array)
    clean_array = array.sort.uniq
    @root = build_tree(clean_array, 0, clean_array.length - 1)
  end

  def build_tree(array, first_index, last_index)
    return nil if first_index > last_index
    mid = (last_index + first_index) / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array, first_index, mid - 1)
    root.right_child = build_tree(array, mid + 1, last_index)
    root
  end

  def insert(value, base=self.root)
    return Node.new(value) if base.nil?

    base.left_child = insert(value, base.left_child) if base > value
    base.right_child = insert(value, base.right_child) if base < value
    base
  end

  def delete(value)
    target = root
    target_parent = nil
    until target == value
      target_parent = target
      if target > value
        target = target.left_child
      else
        target = target.right_child
      end
    end
    place_replacement(target, target_parent)
  end

  def place_replacement(target, target_parent)
    # Case 1 and Case 2 of a deletion target with 0 or 1 child
    if target.left_child.nil? && target.right_child.nil?
      target_parent.left_child == target ? target_parent.left_child = nil : target_parent.right_child = nil
    elsif target.left_child.nil?
      target_parent.left_child == target ? target_parent.left_child = target.right_child : target_parent.right_child = target.right_child
    elsif target.right_child.nil?
      target_parent.left_child == target ? target_parent.left_child = target.left_child : target_parent.right_child = target.left_child
    end
    # Case 3 of a deletion target with 2 children
    if target.left_child && target.right_child
      replacement = target.right_child
      until replacement.left_child.nil?
        replacement_parent = replacement
        replacement = replacement.left_child
      end
      if replacement.right_child
        replacement_parent.left_child = replacement.right_child
        replacement.left_child = target.left_child
        replacement.right_child = target.right_child
        target.left_child = nil
        target.right_child = nil
      elsif replacement_parent
        replacement.left_child = target.left_child
        replacement.right_child = target.right_child
        target.left_child = nil
        target.right_child = nil
        replacement_parent.left_child = nil
      else
        replacement.left_child = target.left_child
        target.left_child = nil
        target.right_child = nil
      end
      if target_parent
        target_parent.left_child == target ? target_parent.left_child = replacement : target_parent.right_child = replacement
      end
    end
  end

  def find_replacement(target)
    replacement = target.right_child
    until replacement.left_child.nil?
      replacement = replacement.left_child
    end
    replacement
  end

  def find(value)
    target = root
    until target == value
      if target > value
        target = target.left_child
      else
        target = target.right_child
      end
    end
    target
  end

  def level_order
    val_array = []
    queue = [root]
    base = root
    until queue.empty?
      queue.push(base.left_child) unless base.left_child.nil?
      queue.push(base.right_child) unless base.right_child.nil?
      val_array.push(base.data)
      queue.shift
      base = queue[0] unless queue[0].nil?
    end
    val_array
  end

  def inorder(base=root,array=[])
    return base.data if base.left_child.nil? && base.right_child.nil?

    array << inorder(base.left_child) unless base.left_child.nil?
    array << base.data
    array << inorder(base.right_child) unless base.right_child.nil?
    array.flatten
  end

  def preorder(base=root,array=[])
    array << base.data
    array << preorder(base.left_child) unless base.left_child.nil?
    array << preorder(base.right_child) unless base.right_child.nil?
    array.flatten
  end

  def postorder(base=root,array=[])
    return base.data if base.left_child.nil? && base.right_child.nil?

    array << postorder(base.left_child) unless base.left_child.nil?
    array << postorder(base.right_child) unless base.right_child.nil?
    array << base.data
    array.flatten
  end

  def height(value, current_height=0, record=[])
    value.is_a?(Integer) ? base = find(value) : base = value
    return current_height if base.left_child.nil? && base.right_child.nil?

    record << height(base.left_child, current_height + 1) unless base.left_child.nil?
    record << height(base.right_child, current_height + 1) unless base.right_child.nil?
    record.max
  end

  def depth(value)
    target = root
    depth = 0
    until target == value
      if target > value
        target = target.left_child
      else
        target = target.right_child
      end
      depth += 1
    end
    depth
  end
end
