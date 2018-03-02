require 'rails_helper'

describe Pool, 'validations' do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end

describe Pool, 'associations' do 
  it { should have_and_belong_to_many(:posts) }
  it { should belong_to(:user) }
end

describe Pool, 'column_specification' do 
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:description).of_type(:text) }
  it { should have_db_column(:user_id) }
end