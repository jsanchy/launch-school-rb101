limit = 15

# change this:
# def fib(first_num, second_num)
# to this:
def fib(first_num, second_num, limit)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"

# the problem is that methods do not have access to local variables outside
# of their own scope. One way the fib method can use the local variable
# limit is if it is passed in as an argument.
