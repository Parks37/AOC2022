require 'byebug'

module Day3
  class Rucksack
    def initialize(items)
      @items = items
    end

    def compartments
      @items.chars.each_slice(@items.length / 2).map(&:join)
      end

    def misplaced_item
      compartments.first.chars.reduce('') do |repeat, char|
        return repeat if repeat.length > 0
        compartments.last.include?(char) ? repeat + char : repeat
      end
    end
  end

  class Group

    def initialize(people)
      @people = people
    end

    def badge
      @people.first.chars.reduce('') do |repeat, char|
        return repeat if repeat.length > 0
        return char if @people.all? { |person| person.include?(char) }
        repeat
      end
    end
  end

  class Packer

    def initialize(file)
      @file = file
    end

    def misplaced_items
      File.readlines(@file).map do |line|
        Rucksack.new(line.strip).misplaced_item
      end
    end

    def badges
      File.readlines(@file).each_slice(3).map do |group|
        Group.new(group.map(&:strip)).badge
      end
    end

    def to_value(letter)
      ('a'..'z').to_a.concat(('A'..'Z').to_a).zip((1..52).to_a).to_h[letter]
    end

    def misplaced_sum
      misplaced_items.map{|x| to_value(x)}.sum
    end

    def badge_sum
      badges.map{|x| to_value(x)}.sum
    end
  end
end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

packer = Day3::Packer.new(from_file)

puts "The sum of the priority values is #{packer.misplaced_sum}"

puts "The sum of the badge values is #{packer.badge_sum}"


