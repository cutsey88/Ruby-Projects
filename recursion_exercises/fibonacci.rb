def fibs(num)
  if num == 0
    result = [0]
  else
    result = [0, 1]
  end
  until result.length == num + 1 do
    result << result[-1] + result[-2]
  end
  result
end

def fibs_rec(num, result=[0], count=1)
  return num if num < 2
  fibs_rec(num - 1) + fibs_rec(num - 2)
end
