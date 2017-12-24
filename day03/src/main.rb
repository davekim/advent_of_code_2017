class Square
  attr_accessor :x, :y, :number

  def initialize(x, y, number)
    @x = x
    @y = y
    @number = number
  end

  def to_s
    "(#{@x}, #{@y}): #{@number}"
  end
end

class SpiralMemory
  attr_accessor :squares

  def initialize(capacity)
    @squares = []
    @capacity = capacity
    _draw
  end

  def access_port
    @squares.first
  end

  def square(number)
    @squares.find { |s| s.number == number }
  end

  def _draw
    up = 1
    left = 2
    down = 2
    right = 2

    @squares.push(Square.new(0, 0, 1))

    while @squares.size < @capacity
      add_right

      up.times do
        add_up
      end
      up += 2

      left.times do
        add_left
      end
      left += 2

      down.times do
        add_down
      end
      down += 2

      right.times do
        add_right
      end
      right += 2
    end
  end

  def add_right
    last = @squares.last
    @squares.push(Square.new(last.x + 1, last.y, last.number + 1))
  end

  def add_up
    last = @squares.last
    @squares.push(Square.new(last.x, last.y + 1, last.number + 1))
  end

  def add_left
    last = @squares.last
    @squares.push(Square.new(last.x - 1, last.y, last.number + 1))
  end

  def add_down
    last = @squares.last
    @squares.push(Square.new(last.x, last.y - 1, last.number + 1))
  end

  def print
    @squares.each { |s| puts s.to_s }
  end
end

def manhattan_distance(square_a, square_b)
  return (square_a.x-square_b.x).abs + (square_a.y-square_b.y).abs
end

if __FILE__ == $0
  part_one_input = 289326
  spiral = SpiralMemory.new(part_one_input)
  puts "Part 1: #{manhattan_distance(spiral.access_port, spiral.square(part_one_input))}"
end
