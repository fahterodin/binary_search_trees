require_relative 'lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "Balanced? -> #{tree.balanced?}"
puts "Inorder: #{tree.inorder}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
tree.insert(120)
tree.insert(150)
tree.insert(125)
tree.pretty_print
puts "Balanced? -> #{tree.balanced?}"
tree = tree.rebalance
puts "Balanced? -> #{tree.balanced?}"
puts "Inorder: #{tree.inorder}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
tree.pretty_print

