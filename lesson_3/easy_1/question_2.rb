=begin

1. != returns false if the arguments are equal to eachother,
   returns true otherwise.
2. putting ! before something, like !user_name, returns true if user_name
   is nil or false, returns false otherwise.
3. putting ! after something, like words.uniq!, only does something if there
   is a method named uniq!. If there isn't, this will result in an error.
   As a practice, but not a guarantee, a method name with a ! at the end is
   one that mutates the caller. However, a method name without ! doesn't
   guarantee that the method doesn't mutate the caller.
4. putting ? before a single character seems to return its string
   representation. In fact, in the docs for literals syntax, specifically
   under the strings section, it says:
     "There is also a character literal notation to represent single character
     strings, which syntax is a question mark (?) followed by a single
     character or escape sequence that corresponds to a single codepoint in the
     script encoding: ..."
5. putting ? after something only does something if there is a method with
   a ? at the end of its name. It usually signifies that the function returns
   a boolean value, but again, there is no guarantee.
6. putting !! before something, like !!user_name, returns false if user_name
   is nil or false, returns true otherwise.
=end
