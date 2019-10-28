def dot_separated_ip_address?(input_string)
  return false unless input_string.count(".") == 3
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end
  return true
end