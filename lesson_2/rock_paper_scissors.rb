VALID_CHOICES = 'rock', 'paper', 'scissors', 'lizard', 'spock'
QUICK_CHOICES = 'r',    'p',     's',        'l',      'v'

OUTCOMES =
  {
    'rock' =>
      {
        'rock' => 'tie',
        'paper' => 'lose',
        'scissors' => 'win',
        'lizard' => 'win',
        'spock' => 'lose'
      },
    'paper' =>
      {
        'rock' => 'win',
        'paper' => 'tie',
        'scissors' => 'lose',
        'lizard' => 'lose',
        'spock' => 'win'
      },
    'scissors' =>
      {
        'rock' => 'lose',
        'paper' => 'win',
        'scissors' => 'tie',
        'lizard' => 'win',
        'spock' => 'lose'
      },
    'lizard' =>
      {
        'rock' => 'lose',
        'paper' => 'win',
        'scissors' => 'lose',
        'lizard' => 'tie',
        'spock' => 'win'
      },
    'spock' =>
      {
        'rock' => 'win',
        'paper' => 'lose',
        'scissors' => 'win',
        'lizard' => 'lose',
        'spock' => 'tie'
      }
  }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def to_valid_choice(player_input)
  case player_input
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 's'
    'scissors'
  when 'l'
    'lizard'
  when 'v'
    'spock'
  else
    player_input
  end
end

def display_results(outcome, player, computer)
  if outcome == 'win'
    prompt("You won!")
  elsif outcome == 'lose'
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end

  prompt("The score is: Player - #{player}, Computer - #{computer}.")

  if player == 5
    prompt("Player is the grand winner!!! Congratulations!!!")
  elsif computer == 5
    prompt("Computer is the grand winner! Better luck next time!")
  end
end

player_score   = 0
computer_score = 0

# Game loop
loop do
  choice = ''

  # Get player's choice
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')} " \
      "(#{QUICK_CHOICES.join(', ')})")
    choice = to_valid_choice(Kernel.gets().chomp().downcase())
    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample()

  # Update score
  player_outcome = OUTCOMES[choice][computer_choice]
  if player_outcome == 'win'
    player_score += 1
  elsif player_outcome == 'lose'
    computer_score += 1
  end

  # Display results
  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")
  display_results(player_outcome, player_score, computer_score)

  # Play another match?
  match_is_over = player_score == 5 || computer_score == 5
  if match_is_over
    prompt("Would you like to play another match?")
    answer = Kernel.gets().chomp().downcase()
    if answer.start_with?('y')
      player_score = 0
      computer_score = 0
    else
      break
    end
  end
end

prompt("Thank you for playing. Good bye!")
