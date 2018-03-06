require 'rails_helper'
require 'database_cleaner'
require './app/services/tag_service'

describe "tags_service" do 
  DatabaseCleaner.strategy = :transaction
  DatabaseCleaner.clean

  describe "#tag_array" do
    let(:service){ TagService.new }

    it "_for(string)" do
      tag = FactoryBot.create(:tag)
      string = [tag.name, tag.name+"_"].join(" ")
      
      tags_array = service.tag_array_for(string)

      expect(tags_array).to include tag
      expect(tags_array.count).to be eql 1
    end
  end

  describe "#tag_names_array" do
    let(:service){ TagService.new }

    it "_with_aliases_for(string)" do 
      tag1 = FactoryBot.create(:tag)
      tag2 = FactoryBot.create(:tag)
      tag3 = FactoryBot.create(:tag)

      tag1.aliases << tag2

      string = [tag3.name, tag2.name].join(" ")

      tags_name_array = service.tag_names_array_with_aliases_for(string)
      expect(tags_name_array).to include tag1.name
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end
end