require_relative 'piece'

class SlidingPiece < Piece
  # bishop / rook / queen
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
    can_move_further = true
    moves = [position]
    until !can_move_further
      current_position = moves.last.dup
      current_position[0] += offset[0]
      current_position[1] += offset[1]

      if !board.on_board?(current_position)
        can_move_further = false
      elsif board.occupied?(current_position)
        if color != board[*current_position].color
          moves << current_position
        else
          can_move_further = false
        end
      else
        moves << current_position
      end
    end

    moves.shift # remove the first position which is not a valid move
    moves
  end
end

class Bishop < SlidingPiece
  def initialize(board, color)
    super
    @offsets = [-1, 1].repeated_permutation(2).to_a
  end

end

class Rook < SlidingPiece
  def initialize(board, color)
    super
    @offsets = [
      [-1, 0],
      [1, 0],
      [0, 1],
      [0, -1]
    ]
  end

end

class Queen < SlidingPiece
  def initialize(board, color)
    super
    @offsets = [-1, 0, 1].repeated_permutation(2).to_a
    @offsets.delete([0, 0])
  end
end
