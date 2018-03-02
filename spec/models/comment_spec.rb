require 'rails_helper'

describe Comment, 'validations' do
  it { should validate_presence_of(:body) }
end

describe Comment, 'associations' do 
  it { should belong_to(:post) }
  it { should belong_to(:user) }
end

describe Comment, 'column_specification' do 
  it { should have_db_column(:commenter).of_type(:string) }
  it { should have_db_column(:body).of_type(:text) }
  it { should have_db_column(:post_id) }
  it { should have_db_column(:user_id) }
end