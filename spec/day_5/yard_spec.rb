require_relative '../../lib/day_5/yard'

RSpec.describe Day5::Loader do
  it 'takes a yard' do
    expect(described_class.new([])).to be_a(Day5::Loader)
  end

  context '[:load]' do
    it 'loads the yard with stacks' do
      yard = []
      loader = described_class.new(yard)
      loader.load([['A']])
      expect(loader.yard).to eq([['A']])
      loader.load([[],['B'],['C']])
      expect(loader.yard).to eq([['A'], ['B'], ['C']])
      loader.load([['D'],[] ,['E']])
      expect(loader.yard).to eq([['D', 'A'], ['B'], ['E', 'C']])
    end
  end

  context '[:parse]' do
    it 'returns an array of stacks' do
      expect(described_class.new([]).parse('[A] [B] [C]')).to eq([['A'], ['B'], ['C']])
      expect(described_class.new([]).parse('[A]    [C]')).to eq([['A'], [], ['C']])
      expect(described_class.new([]).parse('[A]         [C]')).to eq([['A'], [], [], ['C']])
      expect(described_class.new([]).parse('[A]    ')).to eq([['A'], []])
      expect(described_class.new([]).parse('    [A]    ')).to eq([[],['A'], []])
    end
  end
end

RSpec.describe Day5::Mover do
  it 'takes a yard' do
    expect(described_class.new([])).to be_a(Day5::Mover)
  end

  context '[:parse]' do
    it 'returns an array of instructions' do
      expect(described_class.new([]).parse('move 1 from 2 to 1')).to eq([1,1,0])
      expect(described_class.new([]).parse('move 3 from 1 to 3')).to eq([3,0,2])
    end
  end
end

RSpec.describe Day5::Mover9000 do
  context '[:move]' do
    it 'moves a box at a time' do
      yard = [['A','B'], [], ['C']]
      mover = described_class.new(yard)
      mover.move(2, 0, 1)
      expect(mover.yard).to eq([[], ['B', 'A'], ['C']])
    end
  end
end

RSpec.describe Day5::Mover9001 do
  context '[:move]' do
    it 'moves stacks of boxes' do
      yard = [['A','B'], [], ['C']]
      mover = described_class.new(yard)
      mover.move(2, 0, 1)
      expect(mover.yard).to eq([[], ['A', 'B'], ['C']])
    end
  end
end

RSpec.describe Day5::Yard do
  it 'takes a file' do
    expect(described_class.new('spec/day_5/yard_spec.rb')).to be_a(Day5::Yard)
  end

  context '[:sections]' do
    it 'returns the sections of the file' do
      yard = described_class.new(File.join(File.dirname(__FILE__), 'bare.csv'))
      expect(yard.sections).to eq(["[A]\n[B]\n1", "move 1 from 2 to 1\nmove 2 from 1 to 3\n"])
    end
  end

  context '[:load_commands]' do
    it 'returns the load commands' do
      yard = described_class.new(File.join(File.dirname(__FILE__), 'bare.csv'))
      expect(yard.load_commands).to eq(["[A]", "[B]"])
    end
  end

  context '[:move_commands]' do
    it 'returns the move commands' do
      yard = described_class.new(File.join(File.dirname(__FILE__), 'bare.csv'))
      expect(yard.move_commands).to eq(["move 1 from 2 to 1", "move 2 from 1 to 3"])
    end
  end

  context '[:load]' do
    it 'loads the yard with stacks' do
      yard = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      yard.load
      expect(yard.state).to eq([["Z", "N"], ["M", "C", "D"], ["P"]])
    end
  end

  context '[:move]' do
    context 'when the model_number is 9000'
    it 'moves boxes one at a time' do
      yard = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      yard.load
      yard.move
      expect(yard.state).to eq([['C'], ['M'], ['P', 'D', 'N', 'Z']])
    end
  end

  context 'when the model number is 9001' do
    it 'moves stacks of boxes' do
      yard = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'), model_number: 9001)
      yard.load
      yard.move
      expect(yard.state).to eq([['M'], ['C'], ['P', 'Z', 'N', 'D']])
    end
  end

  context '[:tops]' do
    it 'returns the tops of the stacks' do
      yard = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      yard.load
      yard.move
      expect(yard.tops).to eq(['C', 'M', 'Z'])
    end
  end


end
