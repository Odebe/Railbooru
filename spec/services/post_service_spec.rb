require 'rails_helper'

describe "post_service" do 
  #let(:current_user) { FactoryBot.create(:user) }

  def upload_file
     #Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/test_image.jpg')))
  end

  xit 'creates a post' do
    params = {
      post: {
        image: upload_file,
        tags_string: "test test2 expert",
        rating: "safe"
      }
    }
    #post_service = PostService.new(params, current_user)

  end 

end