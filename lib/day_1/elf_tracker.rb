require 'byebug'

module Day1
  class Expedition
    attr_reader :elves

    def initialize(input_file)
      @elves = load_elves(input_file)
    end

    Elf = Struct.new(:food_items) do
      def total_calories
        food_items.sum
      end

      def <=>(other)
        total_calories <=> other.total_calories
      end
    end

    def load_elves(input_file)
      File.read(input_file).split("\n\n").map do |bag|
        food_items = bag.split("\n").map(&:to_i)
        Elf.new(food_items)
      end
    end
  end
end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

expedition = Day1::Expedition.new(from_file)

puts "The elf with the most calories has #{expedition.elves.max.total_calories} calories."

puts "The total calories for the top 3 elves is #{expedition.elves.sort.reverse[0..2].map(&:total_calories).sum}."

