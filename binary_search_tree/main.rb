require_relative 'tree.rb'

=begin
my_tree = Tree.new([2,6,3,9,8,5,7,1])

p my_tree
puts '_____break___'
my_tree.insert(4)
p my_tree
puts my_tree.find(9)
p my_tree.find(6)
=end

other_tree = Tree.new([15,25,20,30,40,45,35,50,70,60,55,65,75,80,85])

p other_tree
puts '______break____-'
p other_tree.preorder
