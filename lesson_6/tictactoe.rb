# rubocop:disable Style/EndOfLine
require 'pry'
# rubocop:enable Style/EndOfLine

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
FIRST_TO_GO = 'choose'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, separator = ', ', joining_word = 'or')
  case arr.length
  when 0
    ''
  when 1
    arr[0]
  when 2
    arr.join(" #{joining_word} ")
  else
    last = arr.pop
    joined = arr.join(separator)
    joined << "#{separator}#{joining_word} #{last}"
  end
end

def first_player
  case FIRST_TO_GO
  when 'player' then return 'p'
  when 'computer' then return 'c'
  else
    first = ''
    loop do
      prompt 'Who goes first, player or computer? (p or c)'
      first = gets.chr.downcase
      break if %(p c).include?(first)
      prompt "Sorry, that's not a valid choice"
    end
    return first
  end
end

def alternate_player(current)
  current == 'p' ? 'c' : 'p'
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def at_risk?(squares, marker)
  squares.count(marker) == 2 &&
  squares.count(INITIAL_MARKER) == 1
end

def find_at_risk_square(line, brd, marker)
  squares_in_line = brd.values_at(*line)
  if at_risk?(squares_in_line, marker)
    # index of the at risk square in the current line
    idx = squares_in_line.index(INITIAL_MARKER)
    line.at(idx)
  end
end

def computer_places_piece!(brd)
  square = nil
  # First, win if able
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end
  # If unable to win, block if needed
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end
  # If no win or block, pick square #5 if available
  square = 5 if empty_squares(brd).include?(5)
  square = square ? square : empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def places_piece!(brd, placer)
  if placer == 'p'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

loop do
  player_score = 0
  computer_score = 0
  loop do
    board = initialize_board
    
    current_player = first_player
    loop do
      display_board(board)
      places_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      winner = detect_winner(board)
      winner == 'Player' ? player_score += 1 : computer_score += 1
      prompt "#{winner} won!"
    else
      prompt "It's a tie!"
    end

    break if [player_score, computer_score].include? 5

    prompt "The score is:"
    prompt "Player: #{player_score}"
    prompt "Computer: #{computer_score}"
    prompt "First to 5 wins the match!"
    prompt "Continue the match? (y or n)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end

  prompt "The final score in the match was:"
  prompt "Player: #{player_score}"
  prompt "Computer: #{computer_score}"

  if player_score == 5
    prompt "Player is the grand champion!"
    prompt "Wow! You must be really good at Tic Tac Toe!"
  elsif computer_score == 5
    prompt "Computer is the grand champion!"
    prompt "Better luck next time!"
  end

  prompt "Would you like to start a new match? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
