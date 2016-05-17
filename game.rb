require_relative "board"
require_relative "player"
require_relative "display"
require_relative "piece"
require_relative "sliding"
require "byebug"

class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
    @display = Display.new(@board)
  end

  def run
    puts "Mark all the spaces on the board!"
    puts "WASD or arrow keys to move the cursor, enter or space to confirm."

    until @board[[7,7]].type == "P"
      start_pos, end_pos = @player.move
      @board.move(start_pos, end_pos) unless @board[end_pos].type == "X"
    end
    @display.render
    puts "Hooray, the board is filled!"
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.run
end
