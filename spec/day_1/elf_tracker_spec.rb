require 'byebug'
require_relative '../../lib/day_1/elf_tracker'

RSpec.describe Day1::Elf do
  it 'has a total_calories method' do
    expect(described_class.new([])).to respond_to(:total_calories)
  end

  it 'has a total_calories method that returns the sum of all the calories' do
    food_items = [10, 20, 30]
    elf = described_class.new(food_items)

    expect(elf.total_calories).to eq(60)
  end

  it 'sorts itself by total_calories' do
    elves = [
      described_class.new([10]),
      described_class.new([20]),
      described_class.new([30])
    ]

    expect(elves.sort).to eq(elves.sort_by(&:total_calories))
  end
end

RSpec.describe Day1::BagInput do
  it 'has a to_i method' do
    expect(described_class.new('')).to respond_to(:to_i)
  end

  it 'has a to_i method that returns an array of integers' do
    bag = described_class.new("1\n2\n3")

    expect(bag.to_i).to eq([1, 2, 3])
  end
end

RSpec.describe Day1::Expedition do
  it 'makes an elf for each entry in the input file'do
    tracker = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(tracker.elves.count).to eq(5)
  end

  it'gives each elf the correct number of food items'do
    tracker = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(tracker.elves[0].food_items.count).to eq(3)
    expect(tracker.elves[1].food_items.count).to eq(1)
    expect(tracker.elves[2].food_items.count).to eq(2)
    expect(tracker.elves[3].food_items.count).to eq(3)
    expect(tracker.elves[4].food_items.count).to eq(1)
  end

  it 'gives each elf the correct number of calories'do
    tracker = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(tracker.elves[0].total_calories).to eq(6000)
    expect(tracker.elves[1].total_calories).to eq(4000)
    expect(tracker.elves[2].total_calories).to eq(11000)
    expect(tracker.elves[3].total_calories).to eq(24000)
    expect(tracker.elves[4].total_calories).to eq(10000)
  end
end
