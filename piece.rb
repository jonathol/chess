class Piece
  attr_reader :type, :current_pos
  # current_pos nil value temporary
  def initialize(type = " ", current_pos = nil)
    @type = type.force_encoding('utf-8')
    @current_pos = current_pos
  end

  def current_pos=(value)
    @current_pos = value
  end

  def to_s
    string = "  #{type}   "
    string
  end

  def valid_move?(pos)
    self.valid_moves.include?(pos)
  end

# param: void
# returns: Array
  def valid_moves

  end
end
