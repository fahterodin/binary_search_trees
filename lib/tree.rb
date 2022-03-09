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

  def delete(value, node = @root, parent = nil)
    # three cases
    # if the node is a leaf, just remove its link from the parent
    # if the node has one child, just let its parent link to its child
    # if the node has two children, look at its right subtree, find the lowest value there(= node with no left child) remove that node (using case 2) and use its value in the current node
    return if node.nil?

    if value < node.data
      delete(value, node.left, node)
    elsif value > node.data
      delete(value, node.right, node)
    # we have found the node with the value
    elsif node.left.nil? && node.right.nil?
      parent.left = nil if parent.left == node
      parent.right = nil if parent.right == node
    elsif node.right.nil?
      parent.right = node.left if parent.right == node
      parent.left = node.left if parent.left == node
    elsif node.left.nil?
      parent.right = node.right if parent.right == node
      parent.left = node.right if parent.left == node
    else
      min = node.right.min_value
      delete(min)
      node.data = min
    end
  end

  def find(value, node = @root)
    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      node
    end
  end

  def level_order
    # traverse the tree in breadth-first level order and yield each node to the block
    # if no block is given it should return an array of values of all the nodes passed
    # use a queue array
    # iteration and recursion possible
    nodes = []
    queue = [@root]
    until queue.empty?
      nodes << queue[0]
      queue.push(queue[0].left) unless queue[0].left.nil?
      queue.push(queue[0].right) unless queue[0].right.nil?
      queue.shift
    end

    if block_given?
      nodes.each { |node| yield(node) }
    else
      values = []
      nodes.each { |node| values << node.data }
      values
    end
  end

  def level_order_recursion(queue = [@root], nodes = [], values = [], &block)
    return values if queue.empty? && !block_given?

    return if queue.empty?

    if block_given?
      yield(queue[0])
    else
      values << queue[0].data
    end

    queue.push(queue[0].left) unless queue[0].left.nil?
    queue.push(queue[0].right) unless queue[0].right.nil?
    queue.shift
    level_order_recursion(queue, nodes, values, &block)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
tree.pretty_print
tree.insert(8)
tree.delete(4)
tree.pretty_print
p tree.find(6)
p tree.level_order
tree.level_order { |node| puts node.data }
p tree.level_order_recursion
tree.level_order_recursion { |node| puts node.data }
