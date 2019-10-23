VALID_CHOICES = ['rock', 'paper', 'scissors']

OUTCOMES =
  {
    'rock' =>
      {
        'rock' => 'tie',
        'paper' => 'lose',
        'scissors' => 'win'
      },
    'paper' =>
      {
        'rock' => 'win',
        'paper' => 'tie',
        'scissors' => 'lose'
      },
    'scissors' =>
      {
        'rock' => 'lose',
        'paper' => 'win',
        'scissors' => 'tie'
      }
  }

def test_method
  prompt('test message')
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_results(player, computer)
  if OUTCOMES[player][computer] == 'win'
    prompt("You won!")
  elsif OUTCOMES[player][computer] == 'lose'
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample()

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
