require_relative 'tree.rb'
my_array = Array.new(15) { rand(1..100) }
my_tree = Tree.new((Array.new(15) { rand(1..100) }))

p my_tree
puts "_____break____"
p my_tree.balanced?
p my_tree.level_order
puts "_____break____"
p my_tree.preorder
puts "_____break____"
p my_tree.postorder
puts "_____break____"
p my_tree.inorder
puts "_____break____"
my_tree.insert(110)
my_tree.insert(111)
my_tree.insert(121)
my_tree.insert(130)
my_tree.insert(140)
my_tree.insert(135)
my_tree.insert(114)
p my_tree.balanced?
puts "_____break____"
new_tree = my_tree.rebalance
p new_tree.balanced?
puts "_____break____"
p new_tree.level_order
puts "_____break____"
p new_tree.preorder
puts "_____break____"
p new_tree.postorder
puts "_____break____"
p new_tree.inorder
