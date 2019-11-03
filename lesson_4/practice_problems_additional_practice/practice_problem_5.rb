# In the array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Find the index of the first name that starts with "Be"

# The below works because the {} for the block has a high enough operator
# precedence to bind to flintstones.index instead of puts.

puts flintstones.index { |name| name.start_with?("Be") }

# If using do ... end, need to enclose the entire argument to puts
# in parentheses, like so,

# puts (flintstones.index { |name| names.start_with?("Be") })

# otherwise the do ... end block will bind to puts
# and flintstones.index will then return an enumerator.

# can also just assign the solution to a variable before using puts
