require_relative '../../lib/day_5/crane'

RSpec.describe Day5::FSM do
  it 'can take a file' do
    expect(described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))).to be_a(described_class)
  end

  it 'has an initial state of 0' do
    expect(described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv')).state).to eq(0)
  end

  context 'when the parser encounters an empty line'do
    it ' increments the state' do
      fsm = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      expect(fsm.state).to eq(0)
      fsm.parse_file
      expect(fsm.state).to eq(2)
    end
  end

  context 'when the parser encounters a line with only numbers' do
    it 'increments the state' do
      fsm = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      expect(fsm.state).to eq(0)
      fsm.parse_file
      expect(fsm.state).to eq(2)
    end
  end

  context '[:parse_line]' do
    context 'when the state is 0' do
      it 'calls [:load_stack]' do
        fsm = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
        expect(fsm).to receive(:load_stack)
        fsm.parse_line('1')
      end
    end

    context 'when the state is 1' do

    end
  end
end