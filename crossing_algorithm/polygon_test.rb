require 'minitest/autorun'
require_relative 'polygon'

class PolygonTest < MiniTest::Test
  def setup
    @g = Grid.new(0,0,50,50)
    @polygon = polygon = Polygon.new()
  end

  def test_square
    points = [[0, 0], [5, 0], [5, 5], [0, 5], [0, 0]]
    points.each do |point|
      @polygon.add(Point.new(point.first, point.last))
    end
    
    assert_equal 25, @polygon.count_squares(@g.squares)
  end

  def test_crowded_vertex
    points = [[0, 0], [0, 2], [2, 0], [6, 4], [6, 0], [0, 0]]
    points.each do |point|
      @polygon.add(Point.new(point.first, point.last))
    end
    
    assert_equal 7, @polygon.count_squares(@g.squares)
  end

  def test_stonehenge_shape
    points = [[0, 0], [1, 0], [1, 1], [2, 1], [2, 0], [3, 0], [3, 2], [0, 2], [0, 0]]
    points.each do |point|
      @polygon.add(Point.new(point.first, point.last))
    end
    
    assert_equal 5, @polygon.count_squares(@g.squares)
  end

  def test_non_convex_shape
    points = [[1, 1], [2, 1], [1, 2], [4, 2], [3, 1], [4, 1], [4, 0], [1, 0], [1, 1]]
    points.each do |point|
      @polygon.add(Point.new(point.first, point.last))
    end
    
    assert_equal 4, @polygon.count_squares(@g.squares)
  end

  def test_convex_shape
    points = [[0, 0],[6, 6],[7, 6],[6, 0],[0, 0]]
    points.each do |point|
      @polygon.add(Point.new(point.first, point.last))
    end
    
    assert_equal 15, @polygon.count_squares(@g.squares)
  end
end