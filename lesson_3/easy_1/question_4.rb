numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1)
numbers = [1, 1, 2, 3, 4, 5]
numbers.delete(1)

=begin

delete_at(1) will delete the value at index 1
numbers will then be [1, 3, 4, 5]

delete(1) will delete all values equal to 1
numbers will then be [2, 3, 4, 5]

=end
