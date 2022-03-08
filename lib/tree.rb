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
end

tree = Tree.new([1, 2, 3, 4, 5])
tree.insert(5)
p tree.root
puts tree.root
 