require 'set'

class Piece
  attr_accessor :board, :color, :position, :offsets #we should remove this eventually
  def initialize(board, color, position)
    # @name = name
    @board = board
    @color = color
    @position = position
  end

  def inspect
    {
      # :color => color,
      # :position => position,
      :class => self.class
    }.inspect
  end

  def move_into_check?(destination)
    dup_board = board.dup
    dup_board.move(position, destination)
    dup_board.in_check?(color)
  end

  def valid_moves
    self.possible_moves.reject { |move| move_into_check?(move) }
  end

end

class Pawn < Piece
  attr_reader :offset, :diagonal_offsets
  def initialize(board, color, position)
    super
    @offset = 0
    color == :b ? @offset = [1, 0] : @offset = [-1, 0]
    if color == :b
      @diagonal_offsets = [[1, 1],[1,-1]]
    else
      @diagonal_offsets = [[-1, 1],[-1,-1]]
    end
  end

  # REFACTORRR!
  def possible_moves
    moves = []
    # check if can move forward
    forward_position = [position[0] + offset[0], position[1] + offset[1]]
    if board.free?(forward_position)
      moves << forward_position
    end

    # check if if can move forward twice (i.e hasn't made a move)
    unless moves.empty?
      if first_row?
        forward2_position = [position[0] + 2*offset[0], position[1] + 2*offset[1]]
        moves << forward2_position if board.free?(forward2_position)
      end
    end

    # check if can move diagonally
    diagonal_offsets.each do |diagonal_offset|
      diagonal_position = position.dup
      diagonal_position[0] += diagonal_offset[0]
      diagonal_position[1] += diagonal_offset[1]

      x,y = diagonal_position
      if board.occupied?([x,y]) && board.on_board?([x,y])
        if board.grid[x][y].color != color
          moves << diagonal_position
        end
      end
    end

    moves
  end

  def first_row?
    ((position[0] == 1) && (color == :b)) || ((position[0] == 6) && (color == :w))
  end

end

# my_board = Board.new
# my_pawn = Pawn.new(my_board, :b, [4, 4]
# p my_pawn.offset
