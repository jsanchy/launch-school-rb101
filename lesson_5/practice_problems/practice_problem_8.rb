# Using the each method, write some code to output all of the vowels from the
# strings.

hsh = {
        first: ['the', 'quick'],
        second: ['brown', 'fox'],
        third: ['jumped'],
        fourth: ['over', 'the', 'lazy', 'dog']
      }

all_vowels = ''
hsh.each do |_, arr|
  arr.each do |str|
    str.chars.each do |char|
      all_vowels << char if 'aeiou'.include?(char)
    end
  end
end

puts all_vowels
