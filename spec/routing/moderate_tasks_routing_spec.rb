require "rails_helper"

RSpec.describe ModerateTasksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/moderate_tasks").to route_to("moderate_tasks#index")
    end

    it "routes to #new" do
      expect(:get => "/moderate_tasks/new").to route_to("moderate_tasks#new")
    end

    it "routes to #show" do
      expect(:get => "/moderate_tasks/1").to route_to("moderate_tasks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/moderate_tasks/1/edit").to route_to("moderate_tasks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/moderate_tasks").to route_to("moderate_tasks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/moderate_tasks/1").to route_to("moderate_tasks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/moderate_tasks/1").to route_to("moderate_tasks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/moderate_tasks/1").to route_to("moderate_tasks#destroy", :id => "1")
    end

  end
end
