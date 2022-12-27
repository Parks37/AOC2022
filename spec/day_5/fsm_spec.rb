require_relative '../../lib/day_5/fsm'

RSpec.describe Day5::StateOne do
  it 'takes a line and a yard' do
    expect(described_class.new([], 'line')).to be_a(Day5::StateOne)
  end

  context '[:advance?]' do
    it 'returns true if the line does not contain letters' do
      expect(described_class.new([], '1').advance?).to be true
    end

    it 'returns false if the line contains letters' do
      expect(described_class.new([], 'line').advance?).to be false
    end
  end

   context '[:next_step]' do
      it 'returns a StateTwo object' do
        expect(described_class.new([], '').next_step).to be_a(Day5::StateTwo)
      end
   end

  context '[:parse_stacks]' do
    it 'returns an array of stacks' do
      expect(described_class.new([], '[A] [B] [C]').parse_stacks).to eq([['A'], ['B'], ['C']])
    end

    context 'when the line does not have a box in every stack' do
      it 'returns an array of stacks with empty stacks' do
        expect(described_class.new([], '    [F]').parse_stacks).to eq([[], ['F']])

        expect(described_class.new([], '[A]    [C]').parse_stacks).to eq([['A'], [], ['C']])

        expect(described_class.new([], '[A]         [C]').parse_stacks).to eq([['A'], [], [], ['C']])

        expect(described_class.new([], '[A]    ').parse_stacks).to eq([['A'], []])

        expect(described_class.new([], '[Q]         [N]             [N]    ').parse_stacks).to eq([['Q'], [], [], ['N'], [], [], [], ['N'], []])

        expect(described_class.new([], '[H]     [B] [D]             [S] [M]').parse_stacks).to eq([['H'], [], ['B'], ['D'], [], [], [], ['S'], ['M']])
      end
    end
  end

  context '[:parse]' do
    it 'loads the yard with stacks' do
      yard = []
      state_one = described_class.new(yard, '[A] [B] [C]')
      state_one.parse
      expect(state_one.yard).to eq([['A'], ['B'], ['C']])
      state_one.line = '[D]    [E]'
      state_one.parse
      expect(state_one.yard).to eq([['D', 'A'], ['B'], ['E', 'C']])
      state_one.line = '    [F]'
      state_one.parse
      expect(state_one.yard).to eq([['D', 'A'], ['F', 'B'], ['E', 'C']])
    end

    it 'can handle lines of different lengths' do
      yard = []
      state_one = described_class.new(yard, '[A] [B] [C] [D]')
      state_one.parse
      expect(state_one.yard.count).to eq(4)

    end
  end
end

RSpec.describe Day5::StateTwo do
  it 'takes a line and a yard' do
    expect(described_class.new([], 'line')).to be_a(Day5::StateTwo)
  end

  context '[:advance?]' do
    it 'returns true ' do
      expect(described_class.new([], '1').advance?).to be true
    end
  end

   context '[:next_step]' do
      it 'returns a StateThree object' do
        expect(described_class.new([], '').next_step).to be_a(Day5::StateThree)
      end
   end

  context '[:parse]' do
    it 'does nothing' do
      yard = ['A', 'B', 'C']
      state_two = described_class.new(yard, '[A] [B] [C]')
      state_two.parse
      expect(state_two.yard).to eq(['A', 'B', 'C'])
    end
  end
end

RSpec.describe Day5::StateThree do
  it 'takes a line and a yard' do
    expect(described_class.new([], 'line')).to be_a(Day5::StateThree)
  end

  context '[:advance?]' do
    it 'returns true' do
      expect(described_class.new([], '').advance?).to be true
    end
  end

   context '[:next_step]' do
      it 'returns a StateFour object' do
        # expect(described_class.new([], '').next_step).to be_a(Day5::StateFour)
        expect(described_class.new([], '').next_step).to be_a(Day5::StateFive)
      end
   end

  context '[:parse]' do
    it 'does nothing' do
      yard = ['A', 'B', 'C']
      state_three = described_class.new(yard, '[A] [B] [C]')
      state_three.parse
      expect(state_three.yard).to eq(['A', 'B', 'C'])
    end
  end
end

RSpec.describe Day5::StateFour do
  it 'takes a line and a yard' do
    expect(described_class.new([], 'line')).to be_a(Day5::StateFour)
  end

  context '[:advance?]' do
    it 'returns false' do
      expect(described_class.new([], '').advance?).to be false
    end
  end

   context '[:next_step]' do
      it 'returns nil' do
        expect(described_class.new([], '').next_step).to be nil
      end
   end

  context '[:parse_move]' do
    it 'returns an array of the move' do
      expect(described_class.new([], 'move 1 from 2 to 1').parse_move).to eq([1, 2, 1])
    end
  end

  context '[:parse]' do
    it 'moves the box from the source to the destination' do
      yard = [["Z", "N"], ["M", "C", "D"], ["P"]]
      state_four = described_class.new(yard, 'move 1 from 2 to 1')
      state_four.parse
      expect(state_four.yard).to eq([["Z", "N", "D"], ["M", "C"], ["P"]])
      state_four.line = 'move 3 from 1 to 3'
      state_four.parse
      expect(state_four.yard).to eq([[], ["M", "C"], ["P", "D", "N", "Z"]])
      state_four.line = 'move 2 from 2 to 1'
      state_four.parse
      expect(state_four.yard).to eq([["C", "M"], [], ["P", "D", "N", "Z"]])
      state_four.line = 'move 1 from 1 to 2'
      state_four.parse
      expect(state_four.yard).to eq([["C"], ["M"], ["P", "D", "N", "Z"]])

    end
  end
end

RSpec.describe Day5::StateFive do
  it 'takes a line and a yard' do
    expect(described_class.new([], 'line')).to be_a(Day5::StateFive)
  end

  context '[:advance?]' do
    it 'returns false' do
      expect(described_class.new([], '').advance?).to be false
    end
  end

  context '[:next_step]' do
    it 'returns nil' do
      expect(described_class.new([], '').next_step).to be nil
    end
  end

  context '[:parse_move]' do
    it 'returns an array of the move' do
      expect(described_class.new([], 'move 1 from 2 to 1').parse_move).to eq([1, 2, 1])
    end
  end

  context '[:parse]' do
    it 'moves the box from the source to the destination' do
      yard = [["Z", "N"], ["M", "C", "D"], ["P"]]
      state_five = described_class.new(yard, 'move 1 from 2 to 1')
      state_five.parse
      expect(state_five.yard).to eq([["Z", "N", "D"], ["M", "C"], ["P"]])
      state_five.line = 'move 3 from 1 to 3'
      state_five.parse
      expect(state_five.yard).to eq([[], ["M", "C"], ["P", "Z", "N", "D"]])
      state_five.line = 'move 2 from 2 to 1'
      state_five.parse
      expect(state_five.yard).to eq([["M", "C"], [], ["P", "Z", "N", "D"]])
      state_five.line = 'move 1 from 1 to 2'
      state_five.parse
      expect(state_five.yard).to eq([["M"], ["C"], ["P", "Z", "N", "D"]])

    end
  end
end

RSpec.describe Day5::FSM do
  it 'can take a file' do
    expect(described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))).to be_a(described_class)
  end

  it 'has an initial state of class 1' do
    expect(described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv')).state).to be_a(Day5::StateOne)
  end

  context '[:parse_line]' do
    context 'when state is 1' do
      it 'adds the stacks to the yard' do
        fsm = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
        fsm.parse_line('[A] [B] [C]')
        expect(fsm.state.yard).to eq([['A'], ['B'], ['C']])
      end
    end

    context 'when state is 2' do
      it 'does nothing' do
        fsm = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
        fsm.state = Day5::StateTwo.new([['A'], ['B'], ['C']], '[D] [E] [F]')
        fsm.parse_line('[D] [E] [F]')
        expect(fsm.state.yard).to eq([['A'], ['B'], ['C']])
      end
    end
  end

  context 'when state is 3' do
    it 'passes the line to State4' do
      fsm = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      fsm.state = Day5::StateThree.new([['A'], ['B'], ['C']], '[D] [E] [F]')
      fsm.parse_line('move 1 from 2 to 1')
      expect(fsm.state.yard).to eq([['A', 'B'], [], ['C']])
    end
  end

  context 'when state is 4' do
    it 'moves the box from the source to the destination' do
      fsm = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      fsm.state = Day5::StateFour.new([['A'], ['B'], ['C']], 'move 1 from 2 to 1')
      fsm.parse_line('move 1 from 2 to 1')
      expect(fsm.state.yard).to eq([['A', 'B'], [], ['C']])
    end
  end

  context '[:parse_file]' do
    it 'returns an array of stacks' do
      fsm = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      fsm.parse_file
      # expect(fsm.state.yard).to eq([['C'], ['M'], ['P', 'D', 'N', 'Z']])
      expect(fsm.state.yard).to eq([['M'], ['C'], ['P', 'Z', 'N', 'D']])
    end
  end
end
