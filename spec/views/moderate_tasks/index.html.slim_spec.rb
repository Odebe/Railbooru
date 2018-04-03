require 'rails_helper'

RSpec.describe "moderate_tasks/index", type: :view do
  before(:each) do
    assign(:moderate_tasks, [
      ModerateTask.create!(
        :type => "",
        :model_type => "",
        :model_id => "",
        :creator => "",
        :passer => ""
      ),
      ModerateTask.create!(
        :type => "",
        :model_type => "",
        :model_id => "",
        :creator => "",
        :passer => ""
      )
    ])
  end

  it "renders a list of moderate_tasks" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
