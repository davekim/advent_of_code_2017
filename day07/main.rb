require 'set'

if __FILE__ == $0
  weights_by_name = Hash.new
  names_that_are_held = Set.new

  File.readlines("input.txt").each do |line|
    name, weight, is_holding, holding_names = line.split(" ", 4)
    weights_by_name[name] = weight.gsub(/[()]/, "").to_i
    names_that_are_held.merge(holding_names.strip.split(", ")) unless is_holding.empty?
  end

  bottom_program = (weights_by_name.keys - names_that_are_held.to_a).first

  # airlri
  puts "Part 1: #{bottom_program}"
end
