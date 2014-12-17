require_relative 'pieces'

class Board
  attr_accessor :grid
  def initialize(blank_board= false)
    @grid = Array.new(8) { Array.new(8, nil) }
    set_board unless blank_board
  end

  def dup
    new_board = Board.new(true)
    grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        old_piece = self[i, j]
        unless old_piece.nil?
          new_piece = old_piece.class.new(new_board, old_piece.color, old_piece.position)
          new_board.add_piece([i, j], new_piece)
        end
      end
    end
    new_board
  end

  def inspect
    inspect_str = ''
    grid.each_with_index do |row,i|
      inspect_str << " \t0\t1\t2\t3\t4\t5\t6\t7\t\n" if i == 0
      row.each_with_index do |el,j|
        inspect_str << "#{i}\t" if j == 0
        unless el.nil?
          inspect_str << "#{el.class.to_s[0]}\t"
        else
          inspect_str << "_\t"
        end
      end
      inspect_str << "\n\n"
    end

    inspect_str
  end

  def [](row, column)
    return grid[row][column] unless column.nil? || row.nil?
    if column.nil?
      grid[row]
    elsif row.nil?
      grid.transpose[column]
    end
  end

  def []=(row, column, assign_val)
    grid[row][column] = assign_val
  end

  def add_piece(coord, piece_obj)
    x , y = coord
    raise "Space not empty" unless self[x, y].nil?
    self[x, y] = piece_obj
    piece_obj.position = [x,y]
  end

  def remove_piece(coord)
    x, y = coord
    raise "Space is empty" if self[x, y].nil?

    self[x,y].position = nil
    self[x, y] = nil
  end

  def set_board
    self.add_piece([0,0],Rook.new)
    grid[0][0] = Rook.new(grid, :b, [0, 0] ) ## use add_piece
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

  def occupied?(coord)
    x, y = coord
    (self.grid[x][y].nil?) ? false : true#default value for empty
  end


  def move(start, destination)
    raise "This tile is empty" unless occupied?(start)

    x ,y = start
    chess_piece = grid[x][y]
    raise "Invalid Move" unless chess_piece.possible_moves.include?(destination)

    # remove the piece from its current spot
    remove_piece(start)

    # remove opponent piece if it exists
    remove_piece(destination) if occupied?(destination)

    # add new piece
    add_piece(destination, chess_piece)
  end

  def in_check?(color)
    king_coord = get_coord(King, color)
    puts "King Coord: #{king_coord}"

    # get all of the opponent's pieces
    opponent_color = (color == :w) ? :b : :w
    opponent_pieces = get_pieces(opponent_color)
    puts "opponent_pieces: #{opponent_pieces}"

    opponent_pieces.any? { |piece|
      p piece
      p piece.possible_moves
      piece.possible_moves.include?(king_coord)
      }
  end

  def get_pieces(color)
    pieces = []

    grid.each_with_index do |row,i|
      row.each_with_index do |piece,j|
        unless piece.nil?
          pieces << self[i,j] if piece.color == color
        end
      end
    end

    pieces
  end

  def get_coord(piece_class, piece_color)
    grid.each_with_index do |row,i|
      grid.each_with_index do |piece,j|
        unless piece.nil?
          if (grid[i][j].class == piece_class ) && (grid[i][j].color == piece_color)
            return [i,j]
          end
        end
      end
    end

    nil
  end

end
