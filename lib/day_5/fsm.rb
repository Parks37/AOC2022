require 'byebug'

module Day5
  class StateX
    attr_accessor :yard, :line

    def initialize(yard, line)
      @yard = yard
      @line = line
    end

    def advance?
      true
    end

    def next_step
      nil
    end

    def parse
    end
  end

  class StateOne < StateX

    def advance?
      @line.strip.match(/[A-z]/) == nil
    end

    def next_step
      StateTwo.new(@yard, @line)
    end

    def parse_stacks
      removed_blanks = @line.gsub(/ {1}( {3})/, '|[]|')
      removed_spaces = removed_blanks.gsub(/ /, '|')
      merged_lines = removed_spaces.gsub(/\|{2,}/, '|')
      remove_proceeding_pipe = merged_lines.gsub(/^\|/, '')

      remove_proceeding_pipe.split('|').map do |box|
        box.match(/\[([A-Z])\]/) ? [$1] : []
      end
    end

    def parse
      parsed_stacks = parse_stacks
      parsed_stacks.each_with_index do |stack, index|
        @yard.push([]) unless @yard[index]
        @yard[index].unshift(stack[0]) unless stack.empty?
      end
    end
  end

  class StateTwo < StateX

    def next_step
      StateThree.new(@yard, @line)
    end

  end

  class StateThree < StateX

    def next_step
      # StateFour.new(@yard, @line)
      StateFive.new(@yard, @line)
    end
  end

  class StateFour < StateX
    def advance?
      false
    end

    def parse_move
      @line.split(' ').filter{ |word| word.match(/[1-9]/) }.map(&:to_i)
    end

    def parse
      quantity, source, destination = parse_move
      while quantity > 0
        @yard[destination - 1].push(@yard[source - 1].pop)
        quantity -= 1
        end
    end
  end

  class StateFive < StateX

    def advance?
      false
    end

    def parse_move
      @line.split(' ').filter{ |word| word.match(/[1-9]/) }.map(&:to_i)
    end

    def parse
      quantity, source, destination = parse_move
      @yard[destination - 1].concat(@yard[source - 1].pop(quantity))
    end
  end


  class FSM
    attr_accessor :state

    def initialize(file)
      @file = file
      @state = StateOne.new([], '')
      @yard =[]
    end

    def parse_file
      File.foreach(@file) do |line|
        parse_line(line)
      end
    end

    def parse_line(line)
      @state.line = line
      @state = @state.next_step if @state.advance?
      @state.parse
    end

    def tops
      @state.yard.map{ |stack| stack.last }
    end
  end
end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

fsm = Day5::FSM.new(from_file)

fsm.parse_file

puts "The tops are #{fsm.tops.join}"

