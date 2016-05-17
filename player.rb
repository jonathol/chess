require_relative "display"

class Player
  def initialize(board)
    @display = Display.new(board)
  end

  def move
    result = Array.new
    until result.size == 2
      @display.render
      moves = @display.get_input
      result << moves if moves.is_a?(Array)
    end    
    result
  end
end
