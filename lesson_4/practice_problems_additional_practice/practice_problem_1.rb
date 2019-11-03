# Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys and the values
# are the positions in the array.

# This solution assumes each value in flintstones in unique
hsh = flintstones.each_with_object({}) do |value, hash|
  hash[value] = flintstones.index(value)
end

puts hsh

# This version doesn't assume each value in flintstones is unique
counter = 0
hsh = flintstones.each_with_object({}) do |value, hash|
  hash[value] = counter
  counter += 1
end

puts hsh

# Their solution
flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

puts flintstones_hash

# Another solution
counter = 0
flint_almost_hash = flintstones.map do |value|
  counter += 1
  [value, counter - 1]
end

flint_hash = flint_almost_hash.to_h
puts flint_hash
