require 'minitest/autorun'
require_relative 'edge'

class EdgeTest < Minitest::Test
  def test_edges_sharing_vertex
    a = Edge.new(Point.new(2,0), Point.new(2,2))
    b = Edge.new(Point.new(3,2), Point.new(2,2))

    assert_equal true, a.intersect?(b)
  end

  def test_orientation
    e = Edge.new(Point.new, Point.new)
    assert_equal :counterclockwise, e.send(:orientation, Point.new(0, 0), Point.new(4, 4), Point.new(1, 2))
  end

  def test_parallel_lines
    a = Edge.new(Point.new(1, 1), Point.new(10, 1))
    b = Edge.new(Point.new(1, 2), Point.new(10, 2))

    assert_equal false, a.intersect?(b)
  end

  def test_crossing_lines
    a = Edge.new(Point.new(10, 0), Point.new(0, 10))
    b = Edge.new(Point.new(0, 0), Point.new(10, 10))

    assert_equal true, a.intersect?(b)
  end
end