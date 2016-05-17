require_relative "piece"

class Sliding < Piece

  def initialize(type, pos)
    super(type, pos)
  end

  def horiz_slide
    x,y = self.current_pos
    list = (0..7).to_a
    list.delete(x)
    list.map { |new_x| [new_x,y] }
  end

  def vert_slide
    x,y = self.current_pos
    list = (0..7).to_a
    list.delete(y)
    list.map { |new_y| [x, new_y] }
  end

  def diag_slide
    x,y = self.current_pos
    # list1 = (0..7).to_a.map {|val| [val, val]}
    # list2 = (0..7).to_a.map {|val| [val, 9-val]}
    up = y-0
    down = 7-y
    right = 7-x
    left = x-0

    result = []
    up_right = []
    up_left = []
    down_left = []
    down_right = []

    limit_ur = 0
    limit_ul = 0
    limit_dl = 0
    limit_dr = 0

    case up<=>right
    when -1
      limit_ur = up
    when 0
      limit_ur = up
    when 1
      limit_ur = right
    end

    case up<=>left
    when -1
      limit_ul = up
    when 0
      limit_ul = up
    when 1
      limit_ul = left
    end

    case down<=>right
    when -1
      limit_dr = down
    when 0
      limit_dr = down
    when 1
      limit_dr = right
    end

    case down<=>left
    when -1
      limit_dl = down
    when 0
      limit_dl = down
    when 1
      limit_dl = left
    end

    number = 1
    while number <= limit_ur
      up_right << [x+number,y-number]
      number += 1
    end
    result.concat(up_right)


    number = 1
    while number <= limit_ul
      up_left << [x-number,y-number]
      number += 1
    end
    result.concat(up_left)

    number = 1
    while number <= limit_dr
      down_right << [x+number,y+number]
      number += 1
    end
    result.concat(down_right)

    number = 1
    while number <= limit_dl
      down_left << [x-number,y+number]
      number += 1
    end
    result.concat(down_left)

    result

  end

  def valid_moves
    foo = []
    foo.concat(horiz_slide)
    foo.concat(vert_slide)
    foo.concat(diag_slide)
    foo
  end
end
