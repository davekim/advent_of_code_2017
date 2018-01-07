if __FILE__ == $0

  registers = Hash.new { |hash, key| hash[key] = 0 }

  file = File.readlines("input.txt").each do |line|
    mr, cmd, mv, cr, operator, cv = line.match(/(^\w+) (inc|dec) (-?\d+) if (\w+) (>|>=|<|<=|!=|==) (-?\d+)/).captures

    if registers[cr].method(operator).(cv.to_i)
      case cmd
      when "inc"
        registers[mr] += mv.to_i
      when "dec"
        registers[mr] -= mv.to_i
      end
    end
  end

  # 4567
  puts "Part 1: #{registers.values.max}"
end
