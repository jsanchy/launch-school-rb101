# puts "the value of 40 + 2 is " + (40 + 2)
# this causes an error because Ruby won't implicitly convert 42 to a string
# when using string concatenation

# we can explicity convert the integer to a string and use concatenation
puts 'the value of 40 + 2 is ' + (40 + 2).to_s

# or we can use string interpolation
puts "the value of 40 + 2 is #{40 + 2}"
