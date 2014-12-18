require_relative 'board'

class Game
  attr_reader :players, :board

  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
    player1.color = :b
    player2.color = :w
  end

  def play
    until over?
      player = get_player
      p board
      start, destination = player.get_move
      begin
        move(player, start, destination)
      rescue MovementError => e
        puts "ERROR: #{e.message}"
        puts "Try again!"
        player = get_player
        next
      end
    end
  end

  def move(player, start, destination)
    raise MovementError.new("This isn't your piece!") if board.occupied?(start) && board[*start].color != player.color
    board.move(start, destination)
  end

  def get_player
    players.reverse!
    players.last
  end

  def over?
    return true if board.checkmate?(:w)||board.checkmate?(:b)
    false
  end

end

class HumanPlayer
  attr_accessor :color

  def get_move
    puts "Your color is #{color}"

    start = get_input("Enter start -> ")
    destination = get_input("Enter end -> ")

    [start, destination]
  end

  def get_input(prompt)
    while true
      print prompt
      input = gets.chomp
      break if valid_input?(input)
    end
    convert_input(input)
  end

  def convert_input(string)
    string.split(",").map(&:to_i)
  end

  def valid_input?(input_string)
    input_string.match(/\d\s*,\s*\d/)
  end

end

class ComputerPlayer
  def initialize(color)
    @color = color
  end
end

if __FILE__ == $PROGRAM_NAME
  h1 = HumanPlayer.new
  h2 = HumanPlayer.new
  game = Game.new(h1,h2)
  game.play

end
