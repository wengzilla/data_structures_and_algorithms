class Grid
  attr_accessor :x_range, :y_range, :squares

  def initialize(min_x, min_y, max_x, max_y)
    @x_range = (min_x...max_x)
    @y_range = (min_y...max_y)
    generate_squares
  end

  def generate_squares
    @squares = [].tap do |squares|
      x_range.each do |x|
        y_range.each do |y|
          squares << Square.new(x, y, x+1, y+1)
        end
      end
    end
  end
end

class Square
  attr_accessor :min_x, :min_y, :max_x, :max_y
  def initialize(min_x, min_y, max_x, max_y)
    @min_x = min_x
    @min_y = min_y
    @max_x = max_x
    @max_y = max_y
  end

  def edges
    @edges ||= [
      Edge.new(Point.new(min_x, min_y), Point.new(min_x, max_y)),
      Edge.new(Point.new(min_x, min_y), Point.new(max_x, min_y)),
      Edge.new(Point.new(min_x, max_y), Point.new(max_x, max_y)),
      Edge.new(Point.new(max_x, max_y), Point.new(max_x, min_y))
    ]
  end

  def to_s
    Point.new(min_x, min_y).inspect
  end
end

