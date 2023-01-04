module Day5

  class Yard
    attr_reader :stacks, :model_number

    def initialize(model_number: 9000)
      @stacks = []
      @model_number = model_number
    end

    def load_stacks(load_instruction)
      load_instruction.stacks.each_with_index do |stack, index|
        stacks.push([]) unless stacks[index]
        stacks[index].unshift(stack.shift) unless stack.empty?
      end
    end

    def move_boxes(move_instruction)
      quantity, source, destination = move_instruction.values_at(:quantity, :source, :destination)
      case model_number
      when 9000
        quantity.times { stacks[destination].push(stacks[source].pop) }
      when 9001
        stacks[destination].concat(stacks[source].pop(quantity))
      end
    end

    def tops
      stacks.map(&:last)
    end
  end


  LoadInstruction = Struct.new(:instruction) do
    def stacks
      full_string = swap_spaces_for_empty_boxes(instruction)
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

  MoveInstruction = Struct.new(:instruction) do
    def to_a
      instruction.match(/move (\d+) from (\d+) to (\d+)/)
      [$1.to_i, $2.to_i, $3.to_i]
    end

    def quantity
      to_a[0]
    end

    def source
      to_a[1] - 1
    end

    def destination
      to_a[2] - 1
    end

    def values_at(*attributes)
      attributes.map { |attribute| send(attribute) }
    end
  end

  LoadInstructions = Struct.new(:instructions) do
    def parse
      instructions.split("\n").filter{ |line| line.match(/[A-z]/) }.map do |instruction|
        LoadInstruction.new(instruction)
      end
    end
  end

  MoveInstructions = Struct.new(:instructions) do
    def parse
      instructions.split("\n").filter{ |line| line.match(/move/) }.map do |instruction|
        MoveInstruction.new(instruction)
      end
    end
  end

  YardInstructions = Struct.new(:from_file) do

    def sections
      File.read(from_file).split("\n\n")
    end

    def load_instructions
      LoadInstructions.new(sections[0])
    end

    def move_instructions
      MoveInstructions.new(sections[1])
    end
  end

  TopFinder = Struct.new(:yard_instructions) do

    def tops(model_number: 9000)
      yard = Day5::Yard.new(model_number: model_number)
      yard_instructions.load_instructions.parse.each do |instruction|
        yard.load_stacks(instruction)
      end

      yard_instructions.move_instructions.parse.each do |instruction|
        yard.move_boxes(instruction)
      end

      yard.tops.join
    end
  end
end



from_file = File.join(File.dirname(__FILE__), 'input.csv')

yard_instructions = Day5::YardInstructions.new(from_file)

puts Day5::TopFinder.new(yard_instructions).tops

puts Day5::TopFinder.new(yard_instructions).tops(model_number: 9001)






