# Create a hash that expresses the frequency with which each letter occurs in
# this string:

statement = "The Flintstones Rock"

# ex:
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

letters = statement.chars.select{|char|char.match(/[[:alpha:]]/)}

frequencies = letters.each_with_object({}) do |letter, hash|
  hash[letter] = hash[letter] ? hash[letter] + 1 : 1
end

puts frequencies
