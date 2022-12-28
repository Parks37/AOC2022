module Day5
  module LoadParser
    def parse (string)
      full_string = swap_spaces_for_empty_boxes(string)
      boxes_seperated_by_pipes = swap_spaces_for_pipes(full_string)
      boxes_seperated_by_single_pipe = swap_multiple_pipes_for_single_pipe(boxes_seperated_by_pipes)
      remove_proceeding_pipe = remove_proceeding_pipe(boxes_seperated_by_single_pipe)

      remove_proceeding_pipe.split('|').map do |box|
        box.match(/\[([A-Z])\]/) ? [$1] : []
      end
    end

    def swap_spaces_for_empty_boxes(string)
      string.gsub(/ {1}( {3})/, '|[]|')
    end

    def swap_spaces_for_pipes(string)
      string.gsub(/ /, '|')
    end

    def swap_multiple_pipes_for_single_pipe(string)
      string.gsub(/\|{2,}/, '|')
    end

    def remove_proceeding_pipe(string)
      string.gsub(/^\|/, '')
    end
  end

  class Loader
    include (Day5::LoadParser)

    attr_reader :yard

    def initialize (yard)
      @yard = yard
    end

    def load(stacks)
      stacks.each_with_index do |stack, index|
        @yard.push([]) unless @yard[index]
        @yard[index].unshift(stack.shift) unless stack.empty?
      end
    end
  end

  module MoveParser
    def parse (string)
      words = string.strip.split(' ')
      numbers_string = words.filter{ |word| word.match(/[1-9]/) }
      quantity, from, to = numbers_string.map(&:to_i)
      [quantity, from-1, to-1]
    end
  end

  class Mover
    include (Day5::MoveParser)

    attr_reader :yard

    def initialize (yard)
      @yard = yard
    end
  end

  class Mover9000 < Mover
    def move (quantity, source, destination)
      while quantity > 0
        @yard[destination].push(@yard[source].pop)
        quantity -= 1
      end
    end
  end

  class Mover9001 < Mover
    def move (quantity, source, destination)
      @yard[destination].concat(@yard[source].pop(quantity))
    end
  end

  class Yard
    attr_reader :state

    def initialize(file, model_number: 9000)
      @file = file
      @model_number = model_number
      @state = []
    end

    def sections
      File.read(@file).split("\n\n")
    end

    def load_commands
      sections[0].split("\n").filter{ |line| line.match(/[A-z]/) }
    end

    def move_commands
      sections[1].split("\n")
    end

    def load
      loader = Day5::Loader.new(@state)
      load_commands.each do |command|
        loader.load(loader.parse(command))
      end
    end

    def move
      case @model_number
      when 9000
        mover = Day5::Mover9000.new(@state)
      when 9001
        mover = Day5::Mover9001.new(@state)
      end
      move_commands.each do |command|
        mover.move(*mover.parse(command))
      end
    end

    def tops
      @state.map{ |stack| stack[-1] }
    end
  end
end

from_file = File.join(File.dirname(__FILE__), 'input.csv')

yard9000 = Day5::Yard.new(from_file)

yard9000.load
yard9000.move

puts "The tops are #{yard9000.tops.join}"

yard9001 = Day5::Yard.new(from_file, model_number: 9001)

yard9001.load
yard9001.move

puts "The tops are #{yard9001.tops.join}"
