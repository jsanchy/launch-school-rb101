TABLE_WIDTH = 40

title = "Flintstone Family Members"

spaces_to_prepend = (TABLE_WIDTH - title.length) / 2
centered_title = " " * spaces_to_prepend + title
puts centered_title

# or just simply use
puts title.center(40)

# note center pads on both sides of the original string
puts centered_title.length
puts title.center(40).length
