require_relative "piece"
require 'byebug'
class Board
  attr_accessor :board
  def initialize()
    @board = Array.new(8){Array.new(8)}
    fill_board
    add_piece([3,3], Sliding.new("\u265B",[3,3]))
    add_piece([7,7], Sliding.new("\u265B",[7,7]))
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @board[x][y] = value
  end

  def move(start, end_pos)
    unless self[start].type == " "
      #debugger
      list = self[start].valid_moves - stop_diaganol(start, end_pos)
      if self[start].is_a?(Sliding) && list.include?(end_pos)#self[start].valid_move?(end_pos)
        self[start].current_pos = end_pos
        self[start], self[end_pos] = self[end_pos], self[start]
      end
    end
  end

  def piece_between?(start, end_pos)

  end

  def stop_diaganol(start, end_pos)
    x0,y0 = start
    x1,y1 = end_pos
    diff_x = x1-x0
    diff_y = y1-y0
    list = []
    #debugger
    unless self[end_pos].type == " "
      to_add = (0...(7-diff_x.abs)).to_a
      to_add.each do |el|
        if diff_x > 0 && diff_y < 0
          list << [x1+el,y1-el]
        elsif diff_x > 0 && diff_y > 0
          list << [x1+el,y1+el]
        elsif diff_x < 0 && diff_y < 0
          list << [x1-el,y1-el]
        else
          list << [x1+el,y1+el]
        end
      end
    end

    list
  end

  def fill_board
    for i in 0...@board.length do
      for j in 0...@board.length do
        add_piece([i,j], Piece.new)
      end
    end
  end
  def add_piece(pos,piece)
    self[pos] = piece
  end

  def rows
    @board
  end

  # TESTING
  # def full?
  #   @board.all? do |row|
  #     row.all? { |piece| piece.type == "P" }
  #   end
  # end
  #
  # def mark(pos)
  #   x, y = pos
  #   @board[x][y] = Piece.new("P")
  # end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end


end
