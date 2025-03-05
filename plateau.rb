class Plateau
  attr_reader :x_coordinate, :y_coordinate, :grid

  def initialize(x_coordinate, y_coordinate)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @grid = set_grid
  end

  private

  def set_grid
    grid = {}
    x_grid = 0
    while x_grid <= @x_coordinate
      y_grid = 0
      while y_grid <= @y_coordinate
        # Create coordinate
        grid[[x_grid, y_grid]] = false
        y_grid += 1
      end
      x_grid += 1
    end
    grid
  end
end

