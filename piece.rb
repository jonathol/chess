require "colorize"

class Piece
  attr_reader :type, :current_pos, :board
  # current_pos nil value temporary
  def initialize(type = " ", current_pos = nil)
    @type = type
    @current_pos = current_pos
  end

  def current_pos=(value)
    @current_pos = value
  end

  def to_s
    string = "  #{type}  ".black
    string
  end

  def valid_move?(pos)
    self.valid_moves.include?(pos)
  end


  def valid_moves

  end
end
