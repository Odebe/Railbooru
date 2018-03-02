require 'rails_helper'

describe User, 'associations' do 
  it { should have_many(:comments) }
  it { should have_many(:posts) }

end

describe User, 'column_specification' do 
  it { should have_db_column(:username).of_type(:string) }
  it { should have_db_column(:user_role).of_type(:boolean) }
  it { should have_db_column(:admin_role).of_type(:boolean) }
end