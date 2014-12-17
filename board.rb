require_relative 'stepping_piece'
require_relative 'sliding_piece'

class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) { Array.new(8, nil) }
    set_board
  end

  def set_board
    grid[0][0] = Rook.new(grid, :b, [0, 0] )
    grid[0][7] = Rook.new(grid, :b, [0, 7] )
    grid[0][1] = Knight.new(grid, :b, [0, 1] )
    grid[0][6] = Knight.new(grid, :b, [0, 6] )
    grid[0][2] = Bishop.new(grid, :b, [0, 2] )
    grid[0][5] = Bishop.new(grid, :b, [0, 5] )
    grid[0][3] = Queen.new(grid, :b, [0, 3] )
    grid[0][4] = King.new(grid, :b, [0, 4] )

    grid[7][0] = Rook.new(grid, :w, [7, 0] )
    grid[7][7] = Rook.new(grid, :w, [7, 7] )
    grid[7][1] = Knight.new(grid, :w, [7, 1] )
    grid[7][6] = Knight.new(grid, :w, [7, 6] )
    grid[7][2] = Bishop.new(grid, :w, [7, 2] )
    grid[7][5] = Bishop.new(grid, :w, [7, 5] )
    grid[7][3] = Queen.new(grid, :w, [7, 3] )
    grid[7][4] = King.new(grid, :w, [7, 4] )

  end

  def free?(new_pos)
    if on_board?(new_pos) && !occupied?(new_pos)
      true
    else
      false
    end
  end

  def on_board?(coord)
    coord.all? { |el| (0...8).cover?(el) }
  end

  # def inspect
  #   output = ""
  #   grid.each do |row|
  #     row.each do |el|
  #       if el.nil?
  #         output << "_\t"
  #       else
  #         output << el.inspect
  #         # if el.class == Rook
  #         #   output << "R\t"
  #         # elsif el.class == Knight
  #         #   output << "K\t"
  #         # elsif el.class == Bishop
  #         #   output << "B\t"
  #         # elsif el.class == Queen
  #         #   output << "Q\t"
  #         # elsif el.class == King
  #         #   output << "Ki\t"
  #         # # when Pawn
  #         #   output << "P\t"
  #         end
  #       end
  #     end
  #     output << "\n"
  #   end
  #
  #   output.inspect
  # end

  def occupied?(coord)
    x, y = coord
    (self.grid[x][y].nil?) ? false : true#default value for empty
  end

  def move(start, destination)
    raise "This tile is empty" unless occupied?(start)

    x ,y = start
    chess_piece = grid[x][y]
    raise "Invalid Move" unless chess_piece.possible_moves.includes?(destination)

    # remove piece from board and add it back in
    grid[x][y] = nil
    i, j = destination
    grid[i][j] = chess_piece
    chess_piece.position = [i,j]
  end
  
end




# x = Board.new
# x.grid[4][4] = "test"
# p x.occupied?([4, 4])
# p x.occupied?([2, 3])
# p x.on_board?([10,3])
# p x.on_board?([5,-3])
# p x.on_board?([8,8])
# p x.on_board?([3,4])
