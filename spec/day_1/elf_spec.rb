require_relative '../../lib/day_1/elf'

describe Day1::Elf do
  it 'has a total_calories method' do
    expect(described_class.new).to respond_to(:total_calories)
  end

  it 'has an add_food_item method' do
    expect(described_class.new).to respond_to(:add_food_item)
  end

  it 'has a total_calories method that returns the sum of all the calories' do
    elf = described_class.new

    elf.add_food_item(10)
    elf.add_food_item(20)
    elf.add_food_item(30)

    expect(elf.total_calories).to eq(60)
  end

  it 'sorts itself by total_calories' do
    elves = [
      described_class.new,
      described_class.new,
      described_class.new
    ]

    elves[0].add_food_item(10)
    elves[1].add_food_item(20)
    elves[2].add_food_item(30)

    expect(elves.sort).to eq(elves.sort_by(&:total_calories))
  end
end
