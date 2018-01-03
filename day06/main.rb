require 'set'

def redistribute(banks)
  configurations = Set.new
  redist_cycles = 0
  c = banks.join(" ")

  until configurations.include?(c) do
    configurations.add(c)

    chosen_index = banks.index(banks.max)
    blocks = banks[chosen_index]
    banks[chosen_index] = 0

    while blocks > 0 do
      chosen_index += 1
      banks[chosen_index % banks.size] += 1
      blocks -= 1
    end

    c = banks.join(" ")
    redist_cycles += 1
  end

  redist_cycles
end

if __FILE__ == $0
  banks = File.read("input.txt").split(" ").map(&:to_i)

  # 14029
  puts "Part 1: #{redistribute(banks)}"

  # 2765
  puts "Part 2: #{redistribute(banks)}"
end
