class Rover
  attr_reader :x_position, :y_position, :orientation

  def initialize(x, y, orientation)
    @x_position = x
    @y_position = y
    @orientation = orientation
    @moves = set_next_moves
  end

  def move(instructions)
    # check for correct input
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

  def determine_direction
    case @orientation
    when "N" then @y_position += 1
    when "S" then @y_position -= 1
    when "E" then @x_position += 1
    when "W" then @x_position -= 1
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
      return orient_left(compass)
    elsif compass[:right] == @orientation
      return orient_right(compass)
    else
      return orient_opposite(compass)
    end
  end

  def orient_right(moves)
    moves[:current], moves[:left], moves[:right], moves[:opposite] = moves[:right], moves[:current], moves[:opposite], moves[:left]
    @orientation = moves[:current]
    moves
  end

  def orient_left(moves)
    moves[:current], moves[:left], moves[:right], moves[:opposite] = moves[:left], moves[:opposite], moves[:current], moves[:right]
    @orientation = moves[:current]
    moves
  end

  def orient_opposite(moves)
    moves[:current], moves[:left], moves[:right], moves[:opposite] = moves[:opposite], moves[:right], moves[:left], moves[:current]
    @orientation = moves[:current]
    moves
  end
end
