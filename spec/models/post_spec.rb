require 'rails_helper'

describe Post, 'validations' do
  it { should validate_presence_of(:image) }
  it { should validate_uniqueness_of(:md5) }
end

describe Post, 'associations' do 
  it { should have_many(:comments) }
  it { should have_and_belong_to_many(:tags) }
  it { should have_and_belong_to_many(:pools) }
  it { should belong_to(:user) }
end

describe Post, 'column_specification' do 
  it { should define_enum_for(:rating) }
  it { should have_db_column(:image).of_type(:string) }
  it { should have_db_column(:samp).of_type(:boolean) }
  it { should have_db_column(:user_id) }
  it { should have_db_column(:md5) }
  it { should have_db_column(:rating) }
end
