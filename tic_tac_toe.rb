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
  puts "Select a position (1 - 9):"
  selection = gets.chomp.to_i
  b[selection] = 'X'
end

def empty_spaces(b)
  b.select { |key, value| value == ' ' }.keys
end

def get_computer_choice(b)
  b[empty_spaces(b).sample] = 'O'
end

def check_for_winner(b)
  winning_rows = [[1, 2, 3], [4, 5, 6], [7, 8 ,9], [1, 4, 7], [2, 5, 8], [3, 6, 9]]
  winning_rows.each do |arr|
    if (b[arr[0]] == "X" && b[arr[1]] == "X" && b[arr[2]] == "X")
      puts "Congratulations, you Win!"
      return true
    elsif (b[arr[0]] == "O" && b[arr[1]] == "O" && b[arr[2]] == "O")
      puts "Computer Wins!"
      return true
    else
      return false
    end
  end
end

loop do
  board = make_board
  print_board(board)
  
  begin
    get_player_choice(board)
    get_computer_choice(board)
    print_board(board)
    binding.pry
  end until check_for_winner(board)
  
  puts "Would you like to play again?(Y/N):"
  play_again = gets.chomp.downcase
  if play_again == 'n'
    puts "Thanks for playing!"
    break
  end
end





















