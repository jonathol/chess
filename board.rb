require_relative "piece"
require 'byebug'

class Board
  attr_accessor :board, :moves
  def initialize()
    @board = Array.new(8){Array.new(8)}
    fill_board
    add_piece([3,3], Sliding.new("Q",[3,3],board))
    add_piece([7,7], Sliding.new("q",[7,7],board))
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
      list = self[start].valid_moves
      unless piece_between1?(start, end_pos)
        if list.include?(end_pos)#self[start].valid_move?(end_pos)
          self[start].current_pos = end_pos
          self[start], self[end_pos] = self[end_pos], self[start]
        end
      end
    end
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

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end
end

