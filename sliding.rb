require_relative "piece"
require "byebug"

class Sliding < Piece
  attr_accessor :board

  def initialize(type, pos, board)
    @board = board
    super(type, pos)
  end
  
  def valid_moves
    valid_list = []
    valid_list.concat(northeast)
    valid_list.concat(northwest)
    valid_list.concat(southeast)
    valid_list.concat(southwest)
    valid_list.concat(up)
    valid_list.concat(down)
    valid_list.concat(left)
    valid_list.concat(right)
    valid_list
  end
  
  private
  
  def left
    x,y = self.current_pos
    valid_list = []
    list = (0...x).to_a.reverse
    list.each do |new_x| 
      if @board[new_x,y].type == " " 
        valid_list << [new_x,y] 
      else
        break
      end
    end
  end
  
  def right
    x,y = self.current_pos
    valid_list = []
    list = ((x+1)..7).to_a
    list.each do |new_x| 
      if @board[new_x,y].type == " " 
        valid_list << [new_x,y] 
      else
        break
      end
    end
  end

  def up
    x,y = self.current_pos
    valid_list = []
    list = (0...y).to_a.reverse
    list.each do |new_y| 
      if @board[x,new_y].type == " " 
        valid_list << [x,new_y] 
      else
        break
      end
    end
  end
  
  def down
    x,y = self.current_pos
    valid_list = []
    list = ((y+1)..7).to_a
    list.each do |new_y| 
      if board[x,new_y].type == " " 
        valid_list << [x,new_y] 
      else
        break
      end
    end
  end

  def northeast
    x,y = self.current_pos
   
    up = y-0
    right = 7-x

    result = []
    up_right = []
    limit_ur = 0
    
    case up<=>right
    when -1
      limit_ur = up
    when 0
      limit_ur = up
    when 1
      limit_ur = right
    end
    
    number = 1
    while number <= limit_ur
      new_x = x+number
      new_y = y-number
      debugger
      if board[new_x,new_y].type == " "
        up_right << [new_x, new_y] 
      else
        break
      end
      number += 1
    end
    result.concat(up_right)
  end
  
  def northwest
    x,y = self.current_pos
   
    up = y-0
    left = x-0
    
    result = []
    up_left = []
    limit_ul = 0
    
    case up<=>left
    when -1
      limit_ul = up
    when 0
      limit_ul = up
    when 1
      limit_ul = left
    end
    
    number = 1
    while number <= limit_ul
      new_x = x-number
      new_y = y-number
      if @board[new_x,new_y].type == " "
        up_left << [new_x, new_y] 
      else
        break
      end
      number += 1
    end
    result.concat(up_left)
  end
    
  def southwest
    x,y = self.current_pos
   
    down = 7-y
    right = 7-x
    
    result = []  
    down_right = []
    limit_dr = 0
    
    case down<=>right
    when -1
      limit_dr = down
    when 0
      limit_dr = down
    when 1
      limit_dr = right
    end
    
    number = 1
    while number <= limit_dr
      new_x = x+number
      new_y = y+number
      if @board[new_x,new_y].type == " "
        down_right << [new_x, new_y]
      else
        break
      end
      number += 1
    end
    result.concat(down_right)
  end
  
  def southeast
    x,y = self.current_pos
  
    down = 7-y
    left = x-0
    
    result = []    
    down_left = []
    limit_dl = 0

    case down<=>left
    when -1
      limit_dl = down
    when 0
      limit_dl = down
    when 1
      limit_dl = left
    end
    
    number = 1
    while number <= limit_dl
      new_x = x-number
      new_y = y+number
      if @board[new_x,new_y].type == " "
        down_left << [new_x,new_y]
      else
        break
      end
      number += 1
    end
    result.concat(down_left)
  end

  
end
