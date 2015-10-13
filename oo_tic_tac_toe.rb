class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  
  attr_accessor :data
  
  def initialize
    @data = {}
    (1..9).each {|position| @data[position] = Square.new(' ') }
  end
  
  def print
    system 'clear'
    puts "#{data[1].marker} | #{data[2].marker} | #{data[3].marker}"
    puts "---------"
    puts "#{data[4].marker} | #{data[5].marker} | #{data[6].marker}"
    puts "---------"
    puts "#{data[7].marker} | #{data[8].marker} | #{data[9].marker}"
  end
  
  def clear
    self.data = {}
    (1..9).each {|position| self.data[position] = Square.new(' ') }
  end
  
  def empty_squares
    data.select { |_, square| square.marker == " " }.keys
  end
  
  def full?
    empty_squares == []
  end
  
  def mark_square(marker, position)
    data[position].mark(marker)
  end
  
  def winning_condition?(marker)
    WINNING_LINES.each do |line|
      return true if @data[line[0]].marker == marker && @data[line[1]].marker == marker && @data[line[2]].marker == marker
    end
    return false
  end
end

class Square
  attr_accessor :marker
  
  def initialize(marker)
    @marker = marker
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
    @board = Board.new
    @player = Player.new("Mike", "X")
    @computer = Player.new("C3PO", "O")
    @current_player = @player
  end
  
  def switch_player
    if @current_player == @player
      @current_player = @computer
    else
      @current_player = @player
    end
  end
  
  def play_again?
    puts "Would you like to play again? (enter: yes or no)"
    play_again = gets.chomp
    if play_again == 'yes'
      @board.clear
    end
  end
  
  def player_choice
    if @current_player == @player
      begin
        puts "Enter a square (0 - 9)"
        position = gets.chomp.to_i
      end until @board.empty_squares.include?(position)
    else
      position = @board.empty_squares.sample
    end
    @board.mark_square(@current_player.marker, position)
  end
  
  def play
    @board.print
    loop do
      
      @board.print
      player_choice
      
      if @board.winning_condition?(@current_player.marker)
        @board.print
        puts "#{@current_player.name} Wins!"
        if !play_again?
          break
        end
      end
      
      switch_player
      if @board.full?
        puts "It's a tie!"
        if !play_again?
          break
        end  
      end
      
    end
  end
end

Game.new.play
























