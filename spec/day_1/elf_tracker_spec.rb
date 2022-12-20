require 'byebug'
require_relative '../../lib/day_1/elf_tracker'

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
