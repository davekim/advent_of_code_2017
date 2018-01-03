def part_one
  file = File.read("input.txt")
  instructions = file.split("\n").map(&:to_i)

  steps_taken = 0
  i = 0

  until instructions[i].nil? do
    offset = instructions[i]
    instructions[i] = offset + 1
    i += offset
    steps_taken += 1
  end

  steps_taken
end

def part_two
  file = File.read("input.txt")
  instructions = file.split("\n").map(&:to_i)

  steps_taken = 0
  i = 0

  until instructions[i].nil? do
    offset = instructions[i]

    if offset >= 3
      instructions[i] = offset - 1
    else
      instructions[i] = offset + 1
    end

    i += offset
    steps_taken += 1
  end

  steps_taken
end

if __FILE__ == $0

  # 373543
  puts "Part 1: #{part_one}"

  # 27502966
  puts "Part 2: #{part_two}"
end
