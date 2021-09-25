module Enumerable
  def my_each
    length = self.length
    for i in 0..length -1 do
      yield(self[i])
    end
  end

  def my_each_with_index
    length = self.length
    for i in 0..length -1 do
      yield(self[i], i)
    end
  end

  def my_select
    matches = []
    length = self.length
    for i in 0..length -1 do
      matches.push(self[i]) if yield(self[i])
    end
    matches
  end

  def my_all?(condition=nil)
    length = self.length
    if block_given?
      for i in 0..length -1 do
        return false unless yield(self[i])
      end
      true
    else
      for i in 0..length -1 do
        return false unless condition === self[i]
      end
      true
    end
  end

  def my_any?(condition=nil)
    length = self.length
    if block_given?
      for i in 0..length -1 do
        return true if yield(self[i])
      end
      false
    else
      for i in 0..length -1 do
        return true if condition === self[i]
      end
      false
    end
  end

  def my_none?(condition=nil)
    length = self.length
    if block_given?
      for i in 0..length -1 do
        return false if yield(self[i])
      end
      true
    else
      for i in 0..length -1 do
        return false if condition === self[i]
      end
      true
    end
  end

  def my_count(arg=nil)
    length = self.length
    if block_given? && arg == nil
      count = 0
      for i in 0..length -1 do
        count += 1 if yield(self[i])
      end
      count
    elsif arg != nil
      count = 0
      for i in 0..length -1 do
        count += 1 if arg == self[i]
      end
      count
    else
      length
    end
  end

  def my_map
    length = self.length
    array = []
    for i in 0..length -1 do
      array << yield(self[i])
    end
    array
  end

  def my_inject(arg=nil)
    length = self.length
    if arg == nil
      result = self[0]
      for i in 1..length -1 do
        result = yield(result, self[i])
      end
      result
    else
      result = arg
      for i in 0..length -1 do
        result = yield(result, self[i])
      end
      result
    end
  end  
end

def multiply_els(array)
  array.my_inject { |res, n| res * n }
end

puts "my_each vs. each"
nums1 = [4, 6, 8]
numbers = [1, 4, 3, 4, 5]

my_proc = Proc.new { |i| i * 2 }
p numbers.map(&my_proc)
p numbers.my_map(&my_proc)
