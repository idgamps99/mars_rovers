class Rover
  attr_reader :x_position, :y_position, :orientation

  def initialize(orientation, x, y)
    @orientation = orientation
    @x_position = x
    @y_position = y
    @moves = set_next_moves
  end

  def move(instructions)
    instructions.chars.each do |instruction|
      determine_move_or_orient(instruction)
    end
  end

  private

  def determine_move_or_orient(instruction)
    case instruction
    when "L", "R" then determine_orientation(instruction)
    when "M" then determine_direction
    else "ERROR MESSAGE HERE"
    end
  end

  def determine_orientation(instruction)
    case instruction
    when "L"
      orient_left(@moves)
    when "R"
      orient_right(@moves)
    else
      "ERROR MESSAGE HERE" # TODO: add proper error checking
    end
  end

  def determine_direction
    case @orientation
    when "N" then @y_position += 1
    when "S" then @y_position -= 1
    when "E" then @x_position += 1
    when "W" then @x_position -= 1
    else "ERROR MESSAGE HERE"
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
    @orientation = m[:current]
    m
  end

  def orient_left(m)
    m[:current], m[:left], m[:right], m[:opposite] = m[:left], m[:opposite], m[:current], m[:right]
    @orientation = m[:current]
    m
  end

  def orient_opposite(m)
    m[:current], m[:left], m[:right], m[:opposite] = m[:opposite], m[:right], m[:left], m[:current]
    @orientation = m[:current]
    m
  end
end
