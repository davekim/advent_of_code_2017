require 'set'

if __FILE__ == $0

  registers = Hash.new { |hash, key| hash[key] = 0 }

  encountered_values = Set.new

  file = File.readlines("input.txt").each do |line|
    mr, cmd, mv, cr, operator, cv = line.match(/(^\w+) (inc|dec) (-?\d+) if (\w+) (>|>=|<|<=|!=|==) (-?\d+)/).captures

    if registers[cr].method(operator).(cv.to_i)
      case cmd
      when "inc"
        registers[mr] += mv.to_i
      when "dec"
        registers[mr] -= mv.to_i
      end
      encountered_values.add(registers[mr])
    end
  end

  # 4567
  puts "Part 1: #{registers.values.max}"

  # 5636
  puts "Part 2: #{encountered_values.max}"
end
