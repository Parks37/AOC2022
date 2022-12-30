require_relative '../../lib/day_2/game'
require 'byebug'


RSpec.describe Day2::RoundInput do
  it 'takes a file' do
    round_input = Day2::RoundInput.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(round_input).to be_a(described_class)
  end

  context '[:to_a]' do
    it 'returns an array of the input' do
      round_input = Day2::RoundInput.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      expect(round_input.to_a).to eq([['A', 'Y'], ['B', 'X'], ['C', 'Z']])
    end
  end
end

RSpec.describe Day2::Opponent do
  it 'takes a key' do
    expect(described_class.new('A')).to be_a(described_class)
  end

  context '[:to_shape]' do
    it 'returns an instance of the shape' do
      expect(described_class.new('A').to_shape).to be_a(Day2::Rock)
      expect(described_class.new('B').to_shape).to be_a(Day2::Paper)
      expect(described_class.new('C').to_shape).to be_a(Day2::Scissors)
    end
  end
end

RSpec.describe Day2::Player do
  it 'takes a key' do
    expect(described_class.new('X')).to be_a(described_class)
  end

  context '[:to_shape]' do
    it 'returns a shape' do
      expect(described_class.new('X').to_shape).to be_a(Day2::Rock)
      expect(described_class.new('Y').to_shape).to be_a(Day2::Paper)
      expect(described_class.new('Z').to_shape).to be_a(Day2::Scissors)
    end
  end
end

RSpec.describe Day2::Game do
  it 'takes an input' do
    expect(described_class.new(Day2::Paper, Day2::Rock)).to be_a(described_class)
  end

  context '[:score]' do
    it 'returns the score' do
      expect(described_class.new(Day2::Paper.new, Day2::Rock.new).score).to eq(8)
      expect(described_class.new(Day2::Rock.new, Day2::Paper.new).score).to eq(1)
      expect(described_class.new(Day2::Scissors.new, Day2::Scissors.new).score).to eq(6)
    end
  end
end

RSpec.describe Day2::Outcome do
  it 'takes a key' do
    expect(described_class.new('X')).to be_a(described_class)
  end

  context '[:to_s]' do
    it 'returns a string' do
      expect(described_class.new('X').to_s).to eq(:beats)
      expect(described_class.new('Y').to_s).to eq(:ties)
      expect(described_class.new('Z').to_s).to eq(:loses_to)
    end
  end
end

RSpec.describe Day2::GameInput do
  it 'takes an array' do
    expect(described_class.new(['A', 'Y'])).to be_a(described_class)
  end

  context '[:opponent]' do
    it 'returns an opponent' do
      expect(described_class.new(['A', 'Y']).opponent).to be_a(Day2::Rock)
    end
  end

  context '[:player]' do
    it 'returns a player' do
      expect(described_class.new(['A', 'Y']).player).to be_a(Day2::Paper)
    end
  end

  context '[:outcome]' do
    it 'returns an outcome' do
      expect(described_class.new(['A', 'Y']).outcome).to eq(:ties)
    end
  end
end


