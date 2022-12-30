require_relative '../../lib/day_2/shape'
require 'byebug'

class Loser < Day2::Shape
end

class Winner < Day2::Shape
end

class TestShape < Day2::Shape
  value 1
  beats Loser
  loses_to Winner
end

RSpec.describe Day2::Shape do
  context [:value] do
    it 'will take a value from the child class' do
      expect(TestShape.new.value).to eq(1)
    end
  end

  context [:beats] do
    it 'returns an instance of the shape it beats' do
      expect(TestShape.new.beats).to be_a(Loser)
    end
  end

  context [:loses_to] do
    it 'returns an instance of the shape it loses to' do
      expect(TestShape.new.loses_to).to be_a(Winner)
    end
  end

  context [:ties] do
    it 'returns an instance of the shape it ties' do
      expect(TestShape.new.ties).to be_a(TestShape)
    end
  end

  context '[:self.name]' do
  it 'will make a method with the name of the child class' do
    expect(TestShape.new).to respond_to(:testshape)
  end

    it 'will return the value plus 3' do
      expect(TestShape.new.testshape).to eq(4)
    end
  end

  context '[:self.beats]' do
    it 'will make a method with the name give to beats' do
      expect(TestShape.new).to respond_to(:loser)

    end

    it 'will return the value plus 6' do
      expect(TestShape.new.loser).to eq(7)
    end
  end

  context '[:self.loses_to]' do
    it 'will make a method with the name given to loses_to' do
      expect(TestShape.new).to respond_to(:winner)
    end

    it 'will return the value' do
      expect(TestShape.new.winner).to eq(1)
    end
  end
end
