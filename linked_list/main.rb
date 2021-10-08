require_relative 'node.rb'
require_relative 'linked_list.rb'

listy = LinkedList.new
listy.append('first')
p listy
puts '____break1______'
puts listy.to_s
listy.append('second')
p listy
puts '____break2______'
p listy.to_s
listy.append('third')
p listy
puts '____break3______'
puts listy.to_s
listy.append('fourth')
p listy
puts '____break4______'
puts listy.to_s
listy.prepend('real first')
p listy
puts '____break5______'
puts listy.to_s
puts listy.tail
puts listy.at(5)
puts listy.contains?('first')
puts listy.contains?('no sir')
puts listy.find('third')
listy.pop
p listy
puts '____break6______'
puts listy.to_s
listy.append('extra guy')
p listy
puts '____break7______'
puts listy.to_s
listy.insert_at('insert_me', 3)
p listy
puts '____break8______'
puts listy.to_s
listy.remove_at(4)
p listy
puts '____break9______'
puts listy.to_s
