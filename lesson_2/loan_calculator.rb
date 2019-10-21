require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def get_input(type)
  result = nil
  loop do
    input = gets.chomp
    empty = input.empty?
    less_than_zero = 
      case type
      when 'i'
        result = input.to_i
        result < 0
      when 'f'
        result = input.to_f
        result < 0
      end

    if empty || less_than_zero
      prompt MESSAGES['invalid_input']
    else
      break
    end
  end
  result
end

def loan_calculator
  puts MESSAGES['loan_amount']
  p = get_input('f')

  puts MESSAGES['apr']
  apr = get_input('f')
  # j is monthly interest rate
  j = apr / 12

  puts MESSAGES['loan_duration']
  duration = get_input('i')
  # n is loan duration in months
  n = duration * 12

  m = p * (j / (1 - (1 + j)**(-n)))

  puts MESSAGES['monthly_payment'] + format('%02.2f', m)
end

puts MESSAGES['welcome']
loop do
  loan_calculator
  puts MESSAGES['another_loan']
  answer = gets.chomp.downcase
  break unless answer == 'y'
end
puts MESSAGES['goodbye']
