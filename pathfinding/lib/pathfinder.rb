require_relative '../lib/landscape'

class Pathfinder
  attr_accessor :landscape, :explored_coords

  def solve(landscape)
    @explored_coords = [landscape.start]
    @landscape = landscape
    queue = [[landscape.start]]

    while queue.any?
      current_path = queue.shift
      current_coords = current_path.last

      return current_path[1..-2] if current_coords == landscape.finish

      queue += possible_moves(current_coords).map do |move|
        explored_coords << move
        current_path + [move]
      end
    end

    return "No path found."
  end

  def possible_moves(coords)
    x, y = coords
    moves = [].tap do |moves|
      moves << [x-1, y] if x > 0
      moves << [x+1, y] if x < columns
      moves << [x, y-1] if y > 0
      moves << [x, y+1] if y < rows
    end

    moves.reject{ |move| explored?(move) || open?(move) }
  end

  def explored?(coords)
    explored_coords.include?(coords)
  end

  def open?(coords)
    ["#", "G"].include?(fetch_coords(coords))
  end

  def rows
    landscape.matrix.length
  end

  def columns
    landscape.matrix.first.length
  end

  def fetch_coords(coords)
    landscape.matrix[coords[1]][coords[0]]
  end
end