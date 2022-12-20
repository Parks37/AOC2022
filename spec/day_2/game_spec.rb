require_relative '../../lib/day_2/game'
require 'byebug'


RSpec.describe Day2::Game do
  it 'returns an array of scores for shape inputs' do
    game = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(game.scores_for_shapes).to eq([8,1,6])
  end

  it 'returns an array of scores for outcome inputs' do
    game = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(game.scores_for_outcomes).to eq([4,1,7])
  end
end
