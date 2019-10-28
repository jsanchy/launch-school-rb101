def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end

# the below has unnecessary duplication removed
# the if statement above just returns what the condition returns,
# so we can just get rid of the if statement
def color_valid(color)
  color == "blue" || color == "green"
  # this works, too
  # %w(blue green).include? color
end
