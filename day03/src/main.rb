Point = Struct.new(:x, :y)
Square = Struct.new(:point, :number, :sum)

class SpiralMemory
  attr_accessor :squares, :first_with_larger_sum

  def initialize(capacity)
    @squares = []
    @point_to_sum = {}
    @capacity = capacity
    @first_with_larger_sum = nil

    _draw
  end

  def _calculate_sum(x, y)
    _adjacent_squares(x, y).inject(0) { |acc, x| acc + x }
  end

  def _adjacent_squares(x, y)
    top_left = @point_to_sum[Point.new(x-1, y+1)]
    top = @point_to_sum[Point.new(x, y+1)]
    top_right = @point_to_sum[Point.new(x+1, y+1)]
    left = @point_to_sum[Point.new(x-1, y)]
    right = @point_to_sum[Point.new(x+1, y)]
    bot_left = @point_to_sum[Point.new(x-1, y-1)]
    bot = @point_to_sum[Point.new(x, y-1)]
    bot_right = @point_to_sum[Point.new(x+1, y-1)]

    [top_left, top, top_right, left, right, bot_left, bot, bot_right].compact
  end

  def _draw
    up = 1
    left = 2
    down = 2
    right = 2

    origin = Point.new(0, 0)
    @squares.push(Square.new(origin, 1, 1))
    @point_to_sum[origin] = 1

    while @squares.size < @capacity
      add_square(1, 0)

      up.times do
        add_square(0, 1)
      end
      up += 2

      left.times do
        add_square(-1, 0)
      end
      left += 2

      down.times do
        add_square(0, -1)
      end
      down += 2

      right.times do
        add_square(1, 0)
      end
      right += 2
    end
  end

  def add_square(dx, dy)
    new_x = @squares.last.point.x + dx
    new_y = @squares.last.point.y + dy
    new_point = Point.new(new_x, new_y)

    sum = nil
    if @first_with_larger_sum.nil?
      sum = _calculate_sum(new_x, new_y)
      if sum > @capacity
        @first_with_larger_sum = sum
      else
        @point_to_sum[new_point] = sum
      end
    end

    @squares.push(Square.new(new_point, @squares.last.number + 1, sum))
  end

  def print
    @squares.each { |point, square| puts square.to_s }
  end
end

def manhattan_distance(a, b)
  return (a.point.x-b.point.x).abs + (a.point.y-b.point.y).abs
end

if __FILE__ == $0
  puzzle_input = 289326
  spiral = SpiralMemory.new(puzzle_input)

  # 419
  access_port = spiral.squares.first
  requested_square = spiral.squares.find { |square| square.number == puzzle_input }
  puts "Part 1: #{manhattan_distance(access_port, requested_square)}"

  # 295229
  puts "Part 2: #{spiral.first_with_larger_sum}"
end
