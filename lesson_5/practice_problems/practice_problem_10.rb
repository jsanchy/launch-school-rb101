# Given the following data structure and without modifying the original array,
# use the map method to return a new array identical in structure to the
# original but where the value of each integer is incremented by 1.


original = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

mapped = original.map do |hsh|
  hsh.transform_values do |value|
    value + 1
  end
end

p original
p mapped
