require_relative 'board'

if __FILE__ == $PROGRAM_NAME
  # my_board = Board.new
  # p my_board.grid
  # puts my_board.inspect
  # my_bishop = Bishop.new(my_board, "black", [3,4])
  # my_rook = Rook.new(my_board, "black", [3,4])
  # my_queen = Queen.new(my_board, "black", [3,4])
  # my_knight = Knight.new(my_board, "black", [4,4])
  # my_king = King.new(my_board, "black", [0,0])
  # my_king.possible_moves


  # my_board = Board.new
  # my_pawn = Pawn.new(my_board, :b, [1, 4])
  # my_board.grid[1][4] = my_pawn
  #
  # opp_queen = Queen.new(my_board, :w, [3, 4])
  # my_board.grid[3][4] = opp_queen
  #
  # opp_rook = Rook.new(my_board, :w, [2, 5])
  # my_board.grid[2][5] = opp_rook
  #
  # p my_pawn.possible_moves

  my_board = Board.new(true)
  my_king = King.new(my_board,:b,[4,4])
  my_board.add_piece([4,4],my_king)
  white_knight = Knight.new(my_board, :w, [4,5])
  my_board.add_piece([4,5], white_knight)
  white_rook = Rook.new(my_board, :w, [4,7])
  my_board.add_piece([4,7], white_rook)

  second_board = my_board.dup
  puts "My board: "
  p my_board
  puts "2nd board: "
  p second_board

  my_board.add_piece([1,1], Queen.new(my_board,:b,[1,1]))
  puts "My board: "
  p my_board
  puts "2nd board: "
  p second_board
  #

end
