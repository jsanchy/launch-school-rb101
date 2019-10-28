def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# Bonus 1: the purpose of number % divisor == 0 is that if it
# returns true, then there is no remainder when dividing number
# by divisor, and therefor divisor is a factor of number

# Bonus 2: the purpose of the last line in the method is to
# implicitly return the array of factors
