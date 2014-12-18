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
      move(player, start, destination)
    end
  end

  def move(player, start, destination)
    raise "You can't move that!" unless board[*start].color == player.color
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
    puts "Enter start"
    start = gets.chomp.split(",").map(&:to_i)
    puts "Enter destination"
    destination = gets.chomp.split(",").map(&:to_i)

    [start, destination]
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
