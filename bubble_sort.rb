def bubble_sort(array)
  little = 0
  big = 0
  sorted = false
  while sorted == false do
    for i in 0..array.length - 2
      if array[i] > array[i + 1]
        big = array[i]
        little = array[i + 1]
        array[i] = little
        array[i + 1] = big
        for j in 0..array.length - 2
          sorted = false
          break unless array[j] <= array[j + 1]  
          sorted = true
        end
      end
    end
  end
  array
end

