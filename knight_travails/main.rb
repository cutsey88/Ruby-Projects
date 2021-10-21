require_relative 'tree.rb'

board = []
for i in 0..7 do
  for j in 0..7 do
    board << [i, j]
  end
end

my_nodes = Tree.new(board)
p my_nodes
p my_nodes.find_node([3,3])
puts 'breaaaaaaaaaaaaaaaaaaaaaaak'
my_nodes.knight_moves([3,3], [4,3])
my_nodes.knight_moves([3,3], [7,3])
