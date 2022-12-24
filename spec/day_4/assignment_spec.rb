require_relative '../../lib/day_4/assignment'

RSpec.describe Day4::Assignment do
  it 'can take a assignment string' do
    expect(described_class.new('2-4')).to be_a(described_class)
  end

  context '[:to_a]' do
    it 'can return an array of the range' do
      expect(described_class.new('2-4').to_a).to eq([2, 3, 4])
    end
  end

  context '[:contains?]' do
    it 'can determine if a range is contained in the assignment' do
      assignment1 = described_class.new('2-4')
      assignment2 = described_class.new('3-4')

      expect(assignment1.contains?(assignment2)).to be_truthy
      expect(assignment2.contains?(assignment1)).to be_falsey
    end
  end

  context '[:overlaps?]' do
    it 'can determine if a range overlaps with the assignment' do
      assignment1 = described_class.new('2-4')
      assignment2 = described_class.new('3-4')
      assignment3 = described_class.new('5-6')

      expect(assignment1.overlaps?(assignment2)).to be_truthy
      expect(assignment2.overlaps?(assignment1)).to be_truthy
      expect(assignment1.overlaps?(assignment3)).to be_falsey
      expect(assignment3.overlaps?(assignment1)).to be_falsey
      expect(assignment2.overlaps?(assignment3)).to be_falsey
      expect(assignment3.overlaps?(assignment2)).to be_falsey

    end
  end
end

RSpec.describe Day4::AssignmentList do
  it 'can take a file' do
    expect(described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))).to be_a(described_class)
  end

  context '[:assignments_eclipsed?]' do
    it 'can determine if any assignment completely eclipsed its pair' do
      assignment_list = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
      assignment_1 = Day4::Assignment.new('2-4')
      assignment_2 = Day4::Assignment.new('3-4')
      expect(assignment_list.assignment_eclipsed?(assignment_1, assignment_2)).to be_truthy
    end
  end

  it 'can find all the assignment pairs in which one eclipses the other' do
    assignment_list = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(assignment_list.eclipsed_assignments.count).to eq(2)
  end

  it 'can find all the assignment pairs in which one overlaps the other' do
    assignment_list = described_class.new(File.join(File.dirname(__FILE__), 'dummy_input.csv'))
    expect(assignment_list.overlapping_assignments.count).to eq(4)
  end



end