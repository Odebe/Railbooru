require 'rails_helper'

describe Tag, 'validations' do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end

describe Tag, 'associations' do 
  it { should have_many(:aliases).through(:tag_aliases) }
  it { should have_many(:inverse_aliases).through(:inverse_tag_aliases) }
end

describe Tag, 'column_specification' do 
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:posts_count).of_type(:integer) }
end

RSpec.describe Tag, :type => :model do
  subject {described_class.new}

  it "is not valid without valid attr" do 
    expect(subject).to_not be_valid
  end

  it "is valid with name" do
    subject.name = "test"
    expect(subject).to be_valid
  end

  it "should has uniq name" do 
    described_class.create!(name: "test")
    subject.name = "test"
    expect(subject).to_not be_valid
  end

end