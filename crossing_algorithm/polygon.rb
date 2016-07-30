require_relative 'edge'
require_relative 'grid'

class Polygon
  attr_accessor :points
  GRID_SIZE = 51

  def initialize()
    @points = []
  end

  def add(point)
    points << point
  end

  def edges
    points[0..-2].each_with_index.map do |point, index|
      Edge.new(points[index], points[index + 1])
    end
  end

  def intersect?(segment)
    edges.any? { |edge| edge.intersect?(segment) }
  end

  def inside?(point)
    ray = Edge.new(point, Point.new(GRID_SIZE, GRID_SIZE))
    sum = edges.inject(0) do |sum, edge|
      sum += edge.intersect?(ray) ? 1 : 0
    end

    sum.odd?
  end

  def on_boundary?(point)
    edges.any? { |edge| edge.on_segment?(point) }
  end

  def contain?(point)
    # puts "#{point} inside: #{inside?(point)}, on_boundary: #{on_boundary?(point)}"
    inside?(point) || on_boundary?(point)
  end

  def boundary_points
    min_x = @points.min_by { |point| point.x }
    max_x = @points.max_by { |point| point.x }
    min_y = @points.min_by { |point| point.y }
    max_y = @points.max_by { |point| point.y }
    [min_x, min_y, max_x, max_y]
  end

  def squares_contained(squares)
    # This algorithm won't work for non-integer coordinates. For that, we would need to add intersection testing.
    squares.select do |square|
      square.edges.all? { |edge| contain?(edge.midpoint) }
    end
  end

  def count_squares(squares)
    squares_contained(squares).length
  end
end

# @grid = Grid.new(0,0,50,50)
# @polygon = Polygon.new
# STDIN.each_line.with_index do |line, index|
#     next if index == 0
#     @polygon.add(Point.new(*line.split(" ").map(&:to_i)))
# end
# puts @polygon.count_squares(@grid.squares)