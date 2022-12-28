module Day4
  class Assignment
    attr_reader :string

    def initialize(string)
      @string = string
    end

    def to_a
      domain = string.split('-')
      (domain[0].to_i..domain[1].to_i).to_a
    end

    def contains?(assignment)
      to_a | assignment.to_a == to_a
    end

    def overlaps?(assignment)
      to_a & assignment.to_a != []
    end
  end

  class AssignmentList
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def assignment_eclipsed?(assignment1, assignment2)
      assignment1.contains?(assignment2) || assignment2.contains?(assignment1)
    end

    def eclipsed_assignments
      File.readlines(file).filter do |line|
        domain = line.split(',')
        assignment1 = Assignment.new(domain.first)
        assignment2 = Assignment.new(domain.last)
        assignment_eclipsed?(assignment1, assignment2)
      end
    end

    def overlapping_assignments
      File.readlines(file).filter do |line|
        domain = line.split(',')
        assignment1 = Assignment.new(domain.first)
        assignment2 = Assignment.new(domain.last)
        assignment1.overlaps?(assignment2) || assignment2.overlaps?(assignment1)
      end
    end
  end
end

assignment_list = Day4::AssignmentList.new(File.join(File.dirname(__FILE__), 'input.csv'))

puts 'The number of overlapping assignments is ' + assignment_list.eclipsed_assignments.count.to_s

puts 'The number of overlapping assignments is ' + assignment_list.overlapping_assignments.count.to_s
