require_relative 'piece'

class SteppingPiece < Piece
  # knight / king / pawn??
  def initialize(board, color)
    super
    @offsets = []
  end

  def possible_moves
    moves = []
    offsets.each do |offset|
      moves += move_direction(offset)
    end
    moves
  end

  def move_direction(offset)
    moves = []
    future_position = position.dup
    future_position[0] += offset[0]
    future_position[1] += offset[1]
    if board.on_board?(future_position) && !board.occupied?(future_position)
      moves << future_position
    elsif board.occupied?(future_position) &&  color != board[future_position].color
      moves << future_position
    end

    moves
  end
end

class Knight < SteppingPiece
  def initialize(board, color)
    super
    @offsets = [
                [2, 1],
                [1, 2],
                [-1, 2],
                [-2, 1],
                [-2, -1],
                [-1, -2],
                [2, -1],
                [1, -2]
                ]
  end
end

class King < SteppingPiece
  def initialize(board, color)
    super
    @offsets = [-1, 0, 1].repeated_permutation(2).to_a
    @offsets.delete([0, 0])
  end
end
