def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

=begin

As opposed to the code in question 3, this code changes my_string to
'pumpkinsrutabaga' and my_array remains unchanged.

In tricky_method_two, the << operator is used, which mutates the caller,
which is the same string object that my_string points to. On the other hand,
an_array_param is simply reassigned to a new array, and the original array
that my_array points to remains unchanged.

=end
