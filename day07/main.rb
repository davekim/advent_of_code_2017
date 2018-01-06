Disc = Struct.new(:name, :weight, :children)

class Tower
  attr_reader :base_name

  def initialize(filename)
    _build_tower(filename)
  end

  def _build_tower(filename)
    @discs_by_name = Hash.new

    File.readlines(filename).each do |line|
      name, weight, is_holding, children = line.split(" ", 4)
      children = children.strip.split(", ") unless is_holding.empty?
      @discs_by_name[name] = Disc.new(name, weight.gsub(/[()]/, "").to_i, children)
    end

    names_that_are_held = @discs_by_name.values.map(&:children).flatten.uniq
    @base_name = (@discs_by_name.keys - names_that_are_held.to_a).first
  end

  def find_corrected_weight
    base = @discs_by_name[base_name]
    traverse(base)
    @corrected_weight
  end

  def traverse(disc)
    if disc.children.nil? || disc.children.empty?
      return
    else
      children = disc.children.map { |name| @discs_by_name[name] }
      weight_sums = children.map { |x| calc_weight(x) }

      if weight_sums.uniq.size != 1
        @corrected_weight = figure_corrective_weight(weight_sums, children)
      end

      children.each do |child|
        traverse(child)
      end
    end
  end

  def calc_weight(disc)
    if disc.children.nil?
      disc.weight
    else
      disc.weight + disc.children
        .map { |name| @discs_by_name[name] }
        .map { |x| calc_weight(x) }
        .inject(:+)
    end
  end

  def figure_corrective_weight(weight_sums, children)
    wrong, corrects = weight_sums
      .zip(children.map(&:weight))
      .group_by { |x| x[0] }
      .partition { |k,v| v.size == 1 }

    # Example of ^ since it's hard to keep type in your head...
    # wrong: [[251, [[251, 68]]]], correct: [[243, [[243, 45], [243, 72]]]]

    wrong_weight_sum = wrong.first[0]
    correct_weight_sum = corrects.first[0]

    # FIXME...the group_by and partition nests arrays, break apart or create struct to name access
    wrong_individual_weight = wrong.first.last.first[1]

    wrong_individual_weight + (correct_weight_sum - wrong_weight_sum)
  end
end


if __FILE__ == $0
  tower = Tower.new("input.txt")

  # airlri
  puts "Part 1: #{tower.base_name}"

  # 1206
  puts "Part 2: #{tower.find_corrected_weight}"
end
