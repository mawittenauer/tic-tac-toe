require 'pry'
puts "Let's play Tic Tac Toe!"

# 1. Make the tic tac toe board.
# 2. Take guesses for player and computer in a loop
# 3. End game when there is a tie or someone wins

def print_board(b)
  system 'clear'
  puts " #{b[1]} | #{b[2]} | #{b[3]} "
  puts "-----------"
  puts " #{b[4]} | #{b[5]} | #{b[6]} "
  puts "-----------"
  puts " #{b[7]} | #{b[8]} | #{b[9]} "
end

def make_board
  b = {}
  (1..9).each { |number| b[number] = ' ' }
  b
end

def get_player_choice(b)
  begin
    puts "Select a position (1 - 9):"
    selection = gets.chomp.to_i
  end until empty_spaces(b).include?(selection)
  b[selection] = 'X'
end

def empty_spaces(b)
  b.select { |key, value| value == ' ' }.keys
end

def get_computer_choice(b)
  b[empty_spaces(b).sample] = 'O'
end

def check_for_winner(board)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    return "Player" if board.values_at(*line).count('X') == 3
    return "Computer" if board.values_at(*line).count('O') == 3
  end
  nil
end

def board_filled?(b)
  empty_spaces(b) == []
end

def announce_winner(winner)
  puts "#{winner} Wins!"
end

loop do
  board = make_board
  print_board(board)
  
  begin
    get_player_choice(board)
    get_computer_choice(board)
    print_board(board)
    winner = check_for_winner(board)
  end until check_for_winner(board) || board_filled?(board)

  if winner
    announce_winner(winner)
  else
    puts "It's a tie!"
  end
  
  puts "Would you like to play again?(Y/N):"
  play_again = gets.chomp.downcase
  if play_again == 'n'
    puts "Thanks for playing!"
    break
  end
end






















