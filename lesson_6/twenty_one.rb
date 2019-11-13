# rubocop:disable Style/EndOfLine
SUITS = %w(C D H S)
# rubocop:enable Style/EndOfLine
VALUES = %w(A K Q J) + (2..10).to_a.map(&:to_s)
MAX_TOTAL = 21
STAY_THRESHOLD = MAX_TOTAL - 4
LOW_ACE_THRESHOLD = MAX_TOTAL - 9
MATCH_WIN_SCORE = 5
NUMBER_OF_PLAYERS = 1

def play_game
  loop do
    welcome
    press_enter

    deck = []
    initialize_deck!(deck)

    players = initialize_players
    dealer = initialize_player('Dealer')

    play_hand!(deck, players, dealer)

    prompt "The match is over!\n\n"
    display_match_score([*players, dealer], 'The final score was:')
    puts "\n"
    display_match_winners(match_winners(players, dealer))
    puts "\n"
    break unless play_again?
  end
end

def display_match_winners(winners)
  if winners.empty?
    prompt "No one reached a score of #{MATCH_WIN_SCORE}, so..."
    prompt 'Nobody wins the match!'
  else
    winners.each { |winner| prompt "#{winner} wins the match!" }
  end
end

def display_hand_winners(players, dealer, winners)
  puts "\n"
  prompt "Let's see who won!"
  press_enter

  display_hands(players, dealer, true)

  prompt "Summary:"
  [*players, dealer].each do |player|
    prompt "#{player[:name]} busted!" if player[:busted]
  end

  winners.each { |winner| prompt winner[:name] + ' won!' }
  puts "\n"
end

def display_hands(players, dealer, reveal_card = false)
  puts "\n================"
  players.each { |player| display_player(player) }
  display_dealer(dealer, reveal_card)
  puts "================\n\n"
end

def display_player(player)
  prompt "#{player[:name]} hand: #{hand_to_string(player[:hand])}"
  prompt "#{player[:name]} total: #{player[:total]}"
end

def display_dealer(dealer, reveal_card = false)
  if reveal_card
    display_player(dealer)
  else
    visible_dealer_hand = dealer[:hand].slice(1, dealer[:hand].size - 1)
    prompt "Dealer hand: ? of ? , #{hand_to_string(visible_dealer_hand)}"
  end
end

def display_match_score(players, message = 'The match score is:')
  prompt message
  players.each do |player|
    prompt "#{player[:name]}: #{player[:match_score]}"
  end
end

def hand_to_string(hand)
  hand = hand.map do |card|
    "#{card[1]} of #{card[0]}"
  end
  hand.join(' , ')
end

def clear_and_pad_screen
  system 'clear'
  puts "\n"
end

def prompt(message)
  puts '>> ' + message
end

def welcome
  clear_and_pad_screen
  prompt 'Welcome to Twenty-One!'
  prompt "First to #{MATCH_WIN_SCORE} wins the match!\n\n"
end

def hit_or_stay(player_name)
  msg = "#{player_name}, hit or stay? (h or s)"
  error_msg = "Invalid input. Enter 'h' or 's'."
  valid = %w(h s)
  validate(msg, error_msg, valid)
end

def play_again?
  msg = 'Would you like to start another match? (y or n)'
  error_msg = "Invalid input. Enter 'y' or 'n'."
  valid = %w(y n)
  validate(msg, error_msg, valid) == 'y'
end

def press_enter
  puts "\n\n\n"
  prompt 'Press Enter to continue...'
  gets
  clear_and_pad_screen
end

def validate(message, error_message, valid_options)
  answer = nil
  loop do
    prompt message
    answer = gets.chomp.downcase
    break if valid_input?(valid_options, answer)
    prompt error_message
  end
  answer
end

def valid_input?(valid_options, input)
  valid_options.include?(input)
end

def initialize_deck!(deck)
  SUITS.each do |suit|
    VALUES.each do |value|
      deck.push([suit, value])
    end
  end
  deck.shuffle!
end

def initialize_players
  players = []
  NUMBER_OF_PLAYERS.times do |player_index|
    players << initialize_player("Player #{player_index + 1}")
  end
  if NUMBER_OF_PLAYERS == 1
    players[0][:name] = 'Player'
  end
  players
end

def initialize_player(player_name)
  {
    name: player_name,
    hand: [],
    total: 0,
    busted: false,
    match_score: 0
  }
end

def play_hand!(deck, players, dealer)
  loop do
    deal_new_hand!(deck, [*players, dealer])
    display_match_score([*players, dealer])
    puts "\n\n\n\nDealing new hand...\n\n\n\n"
    press_enter

    play_each_turn!(deck, players, dealer)

    winners = hand_winners(players, dealer)
    update_score!([*players, dealer], winners)
    display_hand_winners(players, dealer, winners)
    press_enter

    break if match_over?([*players, dealer])
  end
end

def deal_new_hand!(deck, players)
  take_back_cards!(players)
  2.times do |_|
    players.each do |player|
      initialize_deck!(deck) if deck.empty?
      player[:hand].push(deck.pop)
    end
  end

  players.each do |player|
    update_total!(player)
    update_busted!(player)
  end
end

def play_each_turn!(deck, players, dealer)
  loop do
    players.each do |player|
      player_turn!(deck, players, player, dealer)
    end

    break if players.all? { |player| player[:busted] }

    dealer_turn!(deck, dealer)
    break if dealer[:busted]

    prompt 'Dealer stays!'
    break
  end
end

def player_turn!(deck, players, current_player, dealer)
  prompt "#{current_player[:name]}'s turn!"
  display_hands(players, dealer)

  final_choice = play_until_done(deck, players, current_player, dealer)

  if final_choice == 's'
    clear_and_pad_screen
    prompt "#{current_player[:name]} chose to stay!"
  else
    prompt "#{current_player[:name]} busted!"
  end
  press_enter
end

def dealer_turn!(deck, dealer)
  prompt "Dealer's turn!"
  loop do
    press_enter
    break if dealer[:total] >= STAY_THRESHOLD
    prompt 'Dealer hits!'
    hit!(deck, dealer)
    display_dealer(dealer, true)
    prompt 'Dealer busted!' if dealer[:busted]
  end
end

def play_until_done(deck, players, current_player, dealer)
  answer = nil
  loop do
    answer = hit_or_stay(current_player[:name])
    break if answer == 's'
    clear_and_pad_screen
    prompt "#{current_player[:name]} chose to hit!"
    hit!(deck, current_player)
    display_hands(players, dealer)
    break if current_player[:busted]
  end
  answer
end

def match_over?(players)
  players.any? do |player|
    player[:match_score] == 5
  end
end

def match_winners(players, dealer)
  winners = []
  players.each do |player|
    if player[:match_score] == MATCH_WIN_SCORE
      winners << player[:name]
    end
  end

  if dealer[:match_score] == MATCH_WIN_SCORE
    winners << dealer[:name]
  end
  winners
end

def hand_winners(players, dealer)
  non_busted_players = players.reject { |player| player[:busted] }
  winners = if non_busted_players.empty?
              [dealer]
            elsif dealer[:busted]
              non_busted_players
            else
              non_busted_players.select do |player|
                player[:total] > dealer[:total]
              end
            end
  winners.empty? ? [dealer] : winners
end

def hit!(deck, player)
  player[:hand].push(deck.pop)
  update_total!(player)
  update_busted!(player)
end

def take_back_cards!(players)
  players.each do |player|
    player[:hand] = []
  end
end

def update_total!(player)
  player[:total] = total(player[:hand])
end

def update_busted!(player)
  player[:busted] = player[:total] > MAX_TOTAL ? true : false
end

def update_score!(players, winners)
  winner_names = winners.map { |winner| winner[:name] }
  players.each do |player|
    player[:match_score] += 1 if winner_names.include?(player[:name])
  end
end

def total(hand)
  ranks_in_hand = hand.map { |card| card[1] }
  total = initial_total(ranks_in_hand)
  total + additional_ace_value(ranks_in_hand, total)
end

def initial_total(ranks)
  values = ranks.map do |rank|
    rank_to_value(rank)
  end
  values.reduce(&:+)
end

def additional_ace_value(ranks, total)
  add_to_total = 0
  rank_count(ranks, 'A').times do |_|
    if total + add_to_total < LOW_ACE_THRESHOLD
      add_to_total += 10
    end
  end
  add_to_total
end

def rank_to_value(rank)
  if rank == 'A' then 1
  elsif %w(K Q J).include?(rank) then 10
  else rank.to_i
  end
end

def rank_count(ranks, rank_to_count)
  ranks.select { |card| card == rank_to_count }.count
end

play_game

prompt 'Thank you for playing Twenty-One!'
