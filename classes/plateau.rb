class Plateau
  attr_reader :x_coordinate, :y_coordinate, :grid

  def initialize(x_coordinate, y_coordinate)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @grid = set_grid
  end

  def valid_move?(coordinates)
    return false unless valid_input?(coordinates)
    return false unless within_bounds?(coordinates)
    return false unless unoccupied?(coordinates)
    true
  end

  def track(new, old)
    occupy(new)
    unoccupy(old)
  end

  def within_bounds?(coordinates)
    return false unless coordinates[0] <= @x_coordinate && coordinates[1] <= @y_coordinate
    return false unless coordinates[0] >= 0 && coordinates[1] >= 0
    true
  end

  def set_start_position(rover)
    @grid[[rover.x_position, rover.y_position]] = true
  end

  private

  def set_grid
    grid = {}
    x_grid = 0
    while x_grid <= @x_coordinate
      y_grid = 0
      while y_grid <= @y_coordinate
        grid[[x_grid, y_grid]] = false
        y_grid += 1
      end
      x_grid += 1
    end
    grid
  end

  def valid_input?(coordinates)
    return false unless coordinates.is_a?(Array)
    return false unless coordinates[0].is_a?(Integer) && coordinates[1].is_a?(Integer)
    return false unless coordinates.length == 2
    true
  end


  def unoccupied?(coordinates)
    @grid[coordinates] == false
  end

  def occupy(new)
    @grid[new] = true
  end

  def unoccupy(old)
    @grid[old] = false
  end
end
