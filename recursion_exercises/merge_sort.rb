def merge_sort(array)
  result = []
  if array.length < 2
    return array
  else
    left = merge_sort(array[0..array.length / 2 - 1])
    right = merge_sort(array[array.length / 2..-1])
    until left.empty? || right.empty?
      if left[0] < right[0]
        result << left.shift
      else
        result << right.shift
      end
    end
    right.empty? ? result.push(left).flatten : result.push(right).flatten
  end
end

