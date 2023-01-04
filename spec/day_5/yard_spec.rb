require_relative '../../lib/day_5/yard'

RSpec.describe Day5::LoadInstruction do
  it 'parses a load instruction' do
    expect(described_class.new('[A] [B] [C]').stacks).to eq([['A'], ['B'], ['C']])
    expect(described_class.new('[A]    [C]').stacks).to eq([['A'], [], ['C']])
    expect(described_class.new('[A]         [C]').stacks).to eq([['A'], [], [], ['C']])
    expect(described_class.new('[A]    ').stacks).to eq([['A'], []])
    expect(described_class.new('    [A]    ').stacks).to eq([[],['A'], []])
  end
end

RSpec.describe Day5::MoveInstruction do
  it 'parses a move instruction' do
    expect(described_class.new('move 1 from 2 to 1').to_a).to eq([1, 2, 1])
    expect(described_class.new('move 2 from 1 to 3').to_a).to eq([2, 1, 3])
  end

  context ':[quantity]' do
    it 'returns the quantity' do
      expect(described_class.new('move 2 from 1 to 3').quantity).to eq(2)
    end
  end

  context ':[source]' do
    it 'returns the source' do
      expect(described_class.new('move 2 from 1 to 3').source).to eq(0)
    end
  end

  context ':[destination]' do
    it 'returns the destination' do
      expect(described_class.new('move 2 from 1 to 3').destination).to eq(2)
    end
  end

  context '#values_at' do
    it 'returns the values at the given attributes' do
      expect(described_class.new('move 2 from 1 to 3').values_at(:quantity, :source, :destination)).to eq([2, 0, 2])
    end
  end
end

RSpec.describe Day5::LoadInstructions do
  it 'maps each line to a LoadInstruction' do
    load_instructions =described_class.new("[A] [B] [C]\n [D] [E] [F]")

    expect(load_instructions.parse.length).to eq(2)
    expect(load_instructions.parse).to all(be_a(Day5::LoadInstruction))
  end
end

RSpec.describe Day5::MoveInstructions do
  it 'maps each line to a MoveInstruction' do
    move_instructions = described_class.new("move 1 from 2 to 1\nmove 2 from 1 to 3")

    expect(move_instructions.parse.length).to eq(2)
    expect(move_instructions.parse).to all(be_a(Day5::MoveInstruction))
  end
end

RSpec.describe Day5::YardInstructions do
  it 'parses the load instructions' do
    yard_instructions = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))

    expect(yard_instructions.load_instructions.parse.length).to eq(3)
  end

  it 'parses the move instructions' do
    yard_instructions = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))

    expect(yard_instructions.move_instructions.parse.length).to eq(4)
  end

  context '[:tops]' do
    it 'returns the tops of the stacks' do
      yard_instructions = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      expect(yard_instructions.tops).to eq('CMZ')
      expect(yard_instructions.tops(model_number: 9001)).to eq('MCD')
    end
  end
end

RSpec.describe Day5::Yard do
  context '[:load_stacks]' do
    it 'loads the stacks' do
      yard = described_class.new

      expect(yard.stacks).to eq([])
      yard.load_stacks(Day5::LoadInstruction.new('[A] [B] [C]'))
      expect(yard.stacks).to eq([['A'], ['B'], ['C']])
      yard.load_stacks(Day5::LoadInstruction.new('[D]     [E]'))
      expect(yard.stacks).to eq([['D', 'A'], ['B'], ['E', 'C']])
      yard.load_stacks(Day5::LoadInstruction.new('    [F]    '))
      expect(yard.stacks).to eq([['D', 'A'], ['F', 'B'], ['E', 'C']])
    end
  end

  context '[:move_boxes]' do
      it 'moves stacks of boxes' do
        yard = described_class.new

        yard.load_stacks(Day5::LoadInstruction.new('[A] [B] [C]'))
        yard.load_stacks(Day5::LoadInstruction.new('[D] [E] [F]'))
        yard.move_boxes(Day5::MoveInstruction.new('move 1 from 2 to 1'))
        expect(yard.stacks).to eq([['D', 'A', 'B'], ['E'], ['F', 'C']])
        yard.move_boxes(Day5::MoveInstruction.new('move 2 from 1 to 3'))
        expect(yard.stacks).to eq([['D'], ['E'], ['F', 'C', 'A', 'B']])
      end
  end
end


