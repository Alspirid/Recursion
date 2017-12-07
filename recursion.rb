require 'byebug'

def range(start_e, end_e)
    return [] if end_e <= start_e
    range(start_e,end_e-1) + [end_e-1]
end


def sum_array(arr)
  return 0 if arr.empty?
  return arr[0] if arr.length == 1
  sum_array(arr[0...-1]) + arr[-1]
end

def sum(arr)
  arr.reduce(:+)
end

def exp1(base, power)
  return 1 if power == 0
  return base if power == 1
  base * exp1(base, power - 1)
end

def exp2(base, power)
  return 1 if power == 0
  return base if power == 1

  if power.even?
    even_exp = exp2(base, power/2)
    return even_exp * even_exp
  else
    odd_exp = exp2(base, (power-1)/2)
    return base * (odd_exp * odd_exp)
  end
end

class Array

  def deep_dup
    result = []
    self.each do |el|
      if el.is_a?(Array)
        result << el.deep_dup
      else
        result << el
      end
    end
    result
  end

end


def fib(n)
  return [] if n == 0
  return [0] if n == 1
  return [0,1] if n == 2
  old_seq = fib(n-1)
  old_seq + [old_seq[-2]+old_seq[-1]]
end

def fib_i(n)
  return [] if n == 0
  return [0] if n == 1
  return [0,1] if n == 2
  result = [0, 1]
  (2..n-1).to_a.each do |i|
    result << result.last(2).reduce(:+)
  end
  result
end

def subsets(array)
  return [[]] if array.empty?
  return [[],[array[0]]] if array.length == 1

  smaller_array = subsets(array[0...-1]).dup
  smaller_array + smaller_array.map {|el| el + [array[-1]]}
end

def permutations(array)
  return [[array[0]]] if array.length == 1
  # return
  result = []
  prev_perm = permutations(array[0...-1])

  prev_perm.each do |arr|
    temp_arr = arr.dup
    arr.each_index do |i|
      result << temp_arr[0...i] + [array[-1]] + temp_arr[i..-1]
    end
    result << (temp_arr << array[-1])
  end

  result
end

# def permutations(array)
#   return [[array[0]]] if array.length == 1
#   # return
#   result = []
#   prev_perm = permutations(array[0...-1])
#
#   prev_perm.each do |arr|
#     temp_arr = arr.dup
#     arr.each_index do |i|
#
#       result << temp_arr.insert(i,array[-1])
#     end
#     result << (temp_arr << array[-1])
#   end
#
#   result
# end

def factorial(num)
  return 1 if num == 1
  num * factorial(num-1)
end

def bsearch(array, target)
  # debugger
  mid_idx = array.size/2

  return nil if array.empty?
  return mid_idx if array[mid_idx] == target

  right_side = array[mid_idx+1..-1]
  left_side = array[0...mid_idx]

  comparison = array[mid_idx] <=> target
  if comparison == -1
    right_search = bsearch(right_side,target)
    right_search ? right_search + left_side.size + 1 : nil
  elsif comparison == 1
    bsearch(left_side,target)
  end
end


def mergesort(array)
  mid_idx = array.size/2

  return [] if array.empty?
  return [array[0]] if array.length == 1

  right_side = array[mid_idx..-1]
  left_side = array[0...mid_idx]

  merge(mergesort(left_side), mergesort(right_side))

end



def merge(ar1,ar2)
  result = []
  until ar1.empty? || ar2.empty?
    if ar1.first < ar2.first
      result << ar1.shift
    else
      result << ar2.shift
    end
  end
  if ar1.empty?
    result += ar2
  elsif ar2.empty?
    result += ar1
  end
  result
end
