greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

# The result of the last line is {:a=>"hi there"}
# This is because informal_greeting and greetings[:a] point to the same
# string object when informal_greeting calls the << operator. The << operator
# then mutates the caller, changing the string to 'hi there' instead of
# creating a new string.
