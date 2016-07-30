Point = Struct.new(:x, :y) do
  def to_s
    [x, y].inspect
  end
end

class Edge
  attr_accessor :p, :q

  def initialize(p, q)
    raise ArgumentError.new("#{p} #{q}") unless p.is_a?(Point) && q.is_a?(Point)
    @p = p
    @q = q
  end

  def to_s
    "#{p} -> #{q}"
  end

  def midpoint
    Point.new((p.x + q.x) / 2.0, (p.y + q.y) / 2.0)
  end

  # does point lie on edge?
  def on_segment?(point)
    raise ArgumentError.new("#{p}") unless point.is_a?(Point)
    point.x <= [p.x, q.x].max && point.x >= [p.x, q.x].min &&
      point.y <= [p.y, q.y].max && point.y >= [p.y, q.y].min &&
      orientation(p, q, point) == :collinear
  end

  def intersect?(edge)
    raise ArgumentError.new("#{edge}") unless edge.is_a?(Edge)
    o1 = orientation(p, q, edge.p)
    o2 = orientation(p, q, edge.q)
    o3 = orientation(edge.p, edge.q, p)
    o4 = orientation(edge.p, edge.q, q)

    if o1 != o2 && o3 != o4
      true
    elsif o1 == :collinear && on_segment?(edge.p)
      false
    elsif o2 == :collinear && on_segment?(edge.q) 
      false
    elsif o3 == :collinear && edge.on_segment?(p)
      false
    elsif o3 == :collinear && edge.on_segment?(q)
      false
    else
      false
    end
  end

  private

  def orientation(p1, p2, p3)
    raise ArgumentError.new("#{p1.inspect} #{p2.inspect} #{p3.inspect}") unless p1.is_a?(Point) && p2.is_a?(Point) && p3.is_a?(Point)
    diff = (p2.y - p1.y) * (p3.x - p2.x) - (p3.y - p2.y) * (p2.x - p1.x)
    case
    when diff > 0 then :clockwise
    when diff == 0 then :collinear
    else :counterclockwise
    end
  end
end