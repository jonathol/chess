require_relative "piece"
require 'byebug'
class Board
  attr_accessor :board, :moves
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
      list = self[start].diag_slide
      unless piece_between1?(start, end_pos)

        # list = @moves
        if self[start].is_a?(Sliding) && list.include?(end_pos)#self[start].valid_move?(end_pos)
          self[start].current_pos = end_pos
          self[start], self[end_pos] = self[end_pos], self[start]
        end
      end
    end
  end

  def piece_between1?(start, end_pos)
    # Return error/exception if @board[start].class != Sliding
    #ebugger
    moves = self[start].diag_slide.deep_dup
    x0,y0 = start
    x1,y1 = end_pos
    diff_x = x0-x1
    diff_y = y0-y1
    result = []

    if diff_x > 0
      result += moves.select {|move| move.first > x1}
    else
      result += moves.select {|move| move.first < x1}
    end

    if diff_y > 0
      result += moves.select {|move| move.last > y1}
    else
      result += moves.select {|move| move.last < y1}
    end

    result.any? {|pos| self[pos].type != " " }
  end

  def place_between2?(start, end_pos)
    x0,y0 = start
    x1,y1 = end_pos
    diff_x = x1-x0
    diff_y = y1-y0
    list = []
    #debugger
    if diff_x == 0 && diff_y != 0

    elsif diff_x != 0 && diff_y == 0

    else
      to_add = (1...diff_x.abs).to_a
      to_add.each do |el|
        if diff_x > 0 && diff_y < 0
          list << [x0+el,y0-el]
        elsif diff_x > 0 && diff_y > 0
          list << [x0+el,y0+el]
        elsif diff_x < 0 && diff_y < 0
          list << [x0-el,y0-el]
        else
          list << [x0+el,y0+el]
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

class Array
  def deep_dup
    # Argh! Mario and Kriti beat me with a one line version?? Must
    # have used `inject`...
    new_array = []
    self.each do |el|
      new_array << (el.is_a?(Array) ? el.deep_dup : el)
    end
    new_array
  end

  # The renowned one-line inject version of deep_dup
  # Beware inject!
  def dd_inject
    inject([]) { |dup, el| dup << (el.is_a?(Array) ? el.dd_inject : el) }
  end

  # Beware map! The ultimate one-liner.
  def dd_map
    map { |el| el.is_a?(Array) ? el.dd_map : el }
  end
end
