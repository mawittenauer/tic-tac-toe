class Board
  attr_accessor :data

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  
  def initialize
    @data = {}
    (1..9).each {|position| @data[position] = Square.new(' ')}
  end
  
  def print
    system 'clear'
    puts "#{data[1].marker} | #{data[2].marker} | #{data[3].marker}"
    puts "---------"
    puts "#{data[4].marker} | #{data[5].marker} | #{data[6].marker}"
    puts "---------"
    puts "#{data[7].marker} | #{data[8].marker} | #{data[9].marker}"
  end
  
  def empty_squares
    data.select { |_, v| v.empty? }.keys
  end
  
  def clear
    data.map { |_, v| v.marker = " " }
  end
  
  def full?
    empty_squares == []
  end
  
  def mark_square(position, marker)
    data[position].mark(marker)
  end
  
  def winning_condition?(marker)
    WINNING_LINES.any? do |line|
      @data[line[0]].marker == marker && 
      @data[line[1]].marker == marker && 
      @data[line[2]].marker == marker 
    end
  end
end

class Square
  attr_accessor :marker
  
  def initialize(marker)
    @marker = marker
  end
  
  def empty?
    marker == " "
  end
  
  def mark(marker)
    self.marker = marker
  end
end

class Player
  attr_reader :marker, :name
  
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
  def initialize
    puts "Please enter your name:"
    name = gets.chomp
    @player = Player.new(name, 'X')
    @computer = Player.new("Computer", 'O')
    @board = Board.new
    @current_player = @player
  end
  
  def player_choice
    if @current_player == @computer
      position = @board.empty_squares.sample
    else
      begin
        puts "Pick a square (1 - 9)"
        position = gets.chomp.to_i
      end until @board.empty_squares.include?(position)
    end
    @board.mark_square(position, @current_player.marker)
  end

  def switch_player
    if @current_player == @player
      @current_player = @computer
    else
      @current_player = @player
    end
  end

  def play_again?
    puts "Would you like to play again? (enter 'yes' or 'no')"
    play_again = gets.chomp
    return true if play_again == 'yes'
  end
  
  def play
    loop do
      @board.print
      player_choice
      @board.print
      
      if @board.winning_condition?(@current_player.marker)
        puts "#{@current_player.name} Wins!"
        if play_again?
          @board.clear
        else
          break
        end
      end
      
      switch_player
      
      if @board.full?
        puts "It's a tie!"
        if play_again?
          @board.clear
        else
          break
        end
      end
    end
  end

end

Game.new.play
