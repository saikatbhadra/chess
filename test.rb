require_relative 'stepping_piece'
require_relative 'sliding_piece'
require_relative 'board'

if __FILE__ == $PROGRAM_NAME
  my_board = Board.new
  my_bishop = Bishop.new(my_board,"black",[3,3])
  my_rook = Rook.new(my_board,"black",[3,3])
  my_queen = Queen.new(my_board,"black",[3,3])
  p bishop_moves = (my_bishop.possible_moves).to_set
  p rook_moves = my_rook.possible_moves.to_set
  p queen_moves = my_queen.possible_moves.to_set

  p queen_moves == bishop_moves + rook_moves
end
