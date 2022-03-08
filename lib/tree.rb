require_relative 'node'

# def insert(value)
# compare the value to node.data
# if > go to right node
# else go to left node
# continue until node is a leaf (= node doesn't have a right and a left children)
# use the value to create a node, right if >, left if <

class Tree
  attr_reader :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    return if array.empty?

    mid = array.length / 2
    root = Node.new(array[mid])
    left = array.slice(0, mid)
    right = array.slice(mid + 1, array.length)
    root.left = build_tree(left)
    root.right = build_tree(right)
    root
  end

  def insert(value, node = @root)
    if value > node.data
      return node.right = Node.new(value) if node.right.nil?

      insert(value, node.right)
    else
      return if value == node.data

      return node.left = Node.new(value) if node.left.nil?

      insert(value, node.left)
    end
  end

  def delete(value, node = @root, parent = nil, direction = '')
    return if node.nil?

    if value == @root.data
      return @root = Node.new(node.right.data, node.left, node.right.right)
    end

    if value < node.data
      delete(value, node.left, node, 'left')
    elsif value > node.data
      delete(value, node.right, node, 'right')
    elsif node.right.nil? && node.left.nil?
      if direction == 'left'
        parent.left = nil
      else
        parent.right = nil
      end
    elsif node.left.nil?
      if direction == 'left'
        parent.left = node.right
      else
        parent.right = node.right
      end
    elsif node.right.nil?
      if direction == 'left'
        parent.left = node.left
      else
        parent.right = node.left
      end
    else
      if direction == 'left'
        parent.left = Node.new(node.right.data, node.left)
      else
        parent.right = Node.new(node.right.data, node.left)
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
tree.pretty_print
tree.delete(4)
tree.pretty_print
