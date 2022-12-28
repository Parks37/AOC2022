require_relative 'elf'
require 'byebug'

module Day1
  class Expedition
    attr_reader :elves

    def initialize(input_file)

      @elves = [Elf.new]

      File.readlines(input_file).each do |line|
        if line.match(/(\d+)/)
          elves[-1].add_food_item($1.to_i)
        else
          elves << Elf.new
        end
      end
    end
  end
end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

expedition = Day1::Expedition.new(from_file)

puts "The elf with the most calories has #{expedition.elves.max.total_calories} calories."

puts "The total calories for the top 3 elves is #{expedition.elves.sort.reverse[0..2].map(&:total_calories).sum}."

