require 'rails_helper'

RSpec.describe "ModerateTasks", type: :request do
  describe "GET /moderate_tasks" do
    it "works! (now write some real specs)" do
      get moderate_tasks_path
      expect(response).to have_http_status(200)
    end
  end
end
