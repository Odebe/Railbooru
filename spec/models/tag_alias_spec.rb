describe TagAlias, 'validations' do
  it { should validate_presence_of(:tag_id) }
  it { should validate_presence_of(:alias_id) }
end

describe TagAlias, 'associations' do 
  it { should belong_to(:tag) }
  it { should belong_to(:alias) }
end

describe TagAlias, 'column_specification' do 
  it { should have_db_column(:tag_id) }
  it { should have_db_column(:alias_id) }
end