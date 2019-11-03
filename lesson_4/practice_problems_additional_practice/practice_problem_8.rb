# What happens when we modify an array while we are iterating over it?
# What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# Modifying an array while iterating over it may result in unexpected
# behavior. For example, deleting the first element of an array on each
# iteration will change the indices of the rest of the elements,
# and could result in an index range error if the loop was intended to
# iterate over the length of the original array before it was modified.

# The above code will output
# 1
# 3

# What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# The above code will output
# 1
# 2
