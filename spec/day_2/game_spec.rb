require_relative '../../lib/day_2/game'
require 'byebug'


RSpec.describe Day2::RoundInput do
  it 'takes a file' do
    from_file = File.join(File.dirname(__FILE__), 'dummy_input.csv')
    expect(Day2::RoundInput.new(from_file).file).to eq(from_file)
  end

  context '[:to_a]' do
    it 'returns an array of the input' do
      from_file = File.join(File.dirname(__FILE__), 'dummy_input.csv')
      expect(Day2::RoundInput.new(from_file).to_a).to eq([['A', 'Y'], ['B', 'X'], ['C', 'Z']])
    end
  end
end

RSpec.describe Day2::Opponent do
  it 'takes a key' do
    expect(described_class.new('A')).to be_a(described_class)
  end

  context '[:to_shape]' do
    it 'returns an instance of the shape' do
      expect(described_class.new('A').shape).to be_a(Day2::Rock)
      expect(described_class.new('B').shape).to be_a(Day2::Paper)
      expect(described_class.new('C').shape).to be_a(Day2::Scissors)
    end
  end
end

RSpec.describe Day2::Player do
  it 'takes a key' do
    expect(described_class.new('X')).to be_a(described_class)
  end

  context '[:to_shape]' do
    it 'returns a shape' do
      expect(described_class.new('X').shape).to be_a(Day2::Rock)
      expect(described_class.new('Y').shape).to be_a(Day2::Paper)
      expect(described_class.new('Z').shape).to be_a(Day2::Scissors)
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
      expect(described_class.new('X').to_symbol).to eq(:beats)
      expect(described_class.new('Y').to_symbol).to eq(:ties)
      expect(described_class.new('Z').to_symbol).to eq(:loses_to)
    end
  end
end

RSpec.describe Day2::ShapeChoice do
  it 'takes an array' do
    expect(described_class.new(['A', 'Y']).players).to eq(['A', 'Y'])
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

  # context '[:outcome]' do
  #   it 'returns an outcome' do
  #     expect(described_class.new(['A', 'Y']).outcome).to eq(:ties)
  #   end
  # end
end

RSpec.describe Day2::ShapeChooser do
  it 'takes a file' do
    from_file = File.join(File.dirname(__FILE__), 'dummy_input.csv')
    expect(Day2::ShapeChooser.new(from_file)).to be_a(Day2::ShapeChooser)
  end

  context '[:games]' do
    it 'returns an array of games' do
      from_file = File.join(File.dirname(__FILE__), 'dummy_input.csv')
      games = described_class.new(from_file).games
      expect(games).to be_a(Array)
    end

    it 'returns the correct players for each game' do
      from_file = File.join(File.dirname(__FILE__), 'dummy_input.csv')
      games = described_class.new(from_file).games
      first_game = games.first
      expect(first_game.player).to be_a(Day2::Paper)
      expect(first_game.opponent).to be_a(Day2::Rock)

      second_game = games[1]
      expect(second_game.player).to be_a(Day2::Rock)
      expect(second_game.opponent).to be_a(Day2::Paper)

      third_game = games[2]
      expect(third_game.player).to be_a(Day2::Scissors)
      expect(third_game.opponent).to be_a(Day2::Scissors)
    end
  end
end

RSpec.describe Day2::OutcomeChoice do
  it 'takes a opponent key and outcome key' do
    expect(described_class.new(['A', 'Y'])).to be_a(described_class)
  end

  context '[:oppoent]' do
    it 'returns an opponent' do
      expect(described_class.new(['A', 'Y']).opponent).to be_a(Day2::Rock)
    end
  end

  context '[:player]' do
    it 'returns a player' do
      expect(described_class.new(['A', 'Y']).player).to be_a(Day2::Rock)
    end
  end
end


