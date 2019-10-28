def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# there is no difference in terms of behavior. Using <<, the program
# is using the same piece of memory to hold the buffer, while using +
# creates a new array each time a new element is added. So, the buffer
# argument in the first implementation will be mutated, while the
# input_array argument in the second implementation will not be mutated.
