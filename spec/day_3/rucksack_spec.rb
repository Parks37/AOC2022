require_relative '../../lib/day_3/rucksack'


RSpec.describe Day3::Rucksack do
  it 'will take a list of items' do
    expect(Day3::Rucksack.new('sdfkjhlasdfh')).to be_a(Day3::Rucksack)
  end

  it 'divides the items into two compartments' do
    expect(Day3::Rucksack.new('sdfkjhlasdfh').compartments).to eq(['sdfkjh', 'lasdfh'])
    expect(Day3::Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp').compartments).to eq(['vJrwpWtwJgWr', 'hcsFMMfFFhFp'])
    expect(Day3::Rucksack.new('CrZsJsPPZsGzwwsLwLmpwMDw').compartments).to eq(['CrZsJsPPZsGz', 'wwsLwLmpwMDw'])
  end

  it 'finds the repeated items' do
    expect(Day3::Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp').misplaced_item).to eq('p')
    expect(Day3::Rucksack.new('CrZsJsPPZsGzwwsLwLmpwMDw').misplaced_item).to eq('s')
  end

  context [:misplaced_item] do
    it 'honors case' do
      expect(Day3::Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp').misplaced_item).to eq('p')
      expect(Day3::Rucksack.new('CrZsJsPPZsGzwwsLwLmpwMDw').misplaced_item).to eq('s')
    end
  end
end

RSpec.describe Day3::Group do
  it 'will take a list of people' do
    expect(Day3::Group.new('sdfkjhlasdfh')).to be_a(Day3::Group)
  end

  it 'can find the letter that is common to all people' do
    person1 = 'abc'
    person2 = 'cde'
    person3 = 'fcg'
    expect(Day3::Group.new([person1, person2, person3]).badge).to eq('c')
  end
end

RSpec.describe Day3::Packer do
  it 'will take a file' do
    packer = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(packer).to be_a(Day3::Packer)

  end

  it 'will find the misplaced items' do
    packer = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(packer.misplaced_items).to eq(['p','L','P','v','t','s'])
  end

  it 'can convert a letter to a value' do
    packer = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(packer.to_value('a')).to eq(1)
    expect(packer.to_value('Z')).to eq(52)
  end

  it 'can sum the values of the misplaced items' do
    packer = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(packer.misplaced_sum).to eq(157)
  end

  it 'can find the badge for each group of 3 people' do
    packer = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(packer.badges).to eq(['r','Z'])
  end

  it 'can sum the values of the badges' do
    packer = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(packer.badge_sum).to eq(70)
  end
end
