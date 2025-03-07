class Rover
  attr_reader :x_position, :y_position, :orientation, :next_x, :next_y, :next_moves, :next_orientation

  def initialize(x, y, orientation)
    @x_position = x.to_i
    @y_position = y.to_i
    @orientation = orientation
    @next_x = @x_position
    @next_y = @y_position
    @next_orientation = @orientation
    @moves = set_next_moves
    @next_moves = @moves
  end

  def calculate_move(instruction)
    case instruction
    when "L", "R" then determine_orientation(instruction)
    when "M" then determine_direction
    end

  def move
    @x_position  = @next_x
    @y_position  = @next_y
    @orientation = @next_orientation
    @moves       = @next_moves
  end

  private

  def determine_orientation(instruction)
    case instruction
    when "L"
      orient_left(@next_moves)
    when "R"
      orient_right(@next_moves)
    end
  end

  def determine_direction
    case @next_orientation
    when "N" then @next_y += 1
    when "S" then @next_y -= 1
    when "E" then @next_x += 1
    when "W" then @next_x -= 1
    end
  end

  def set_next_moves
    compass = {
      current: "N",
      right: "E",
      left: "W",
      opposite: "S"
    }

    if compass[:current] == @orientation
      compass
    elsif compass[:left] == @orientation
      orient_left(compass)
    elsif compass[:right] == @orientation
      orient_right(compass)
    else
      orient_opposite(compass)
    end
  end

  def orient_right(m)
    m[:current], m[:left], m[:right], m[:opposite] = m[:right], m[:current], m[:opposite], m[:left]
    @next_orientation = m[:current]
    m
  end

  def orient_left(m)
    m[:current], m[:left], m[:right], m[:opposite] = m[:left], m[:opposite], m[:current], m[:right]
    @next_orientation = m[:current]
    m
  end

  def orient_opposite(m)
    m[:current], m[:left], m[:right], m[:opposite] = m[:opposite], m[:right], m[:left], m[:current]
    @next_orientation = m[:current]
    m
  end
end
