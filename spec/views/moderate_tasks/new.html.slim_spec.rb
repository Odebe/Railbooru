require 'rails_helper'

RSpec.describe "moderate_tasks/new", type: :view do
  before(:each) do
    assign(:moderate_task, ModerateTask.new(
      :type => "",
      :model_type => "",
      :model_id => "",
      :creator => "",
      :passer => ""
    ))
  end

  it "renders new moderate_task form" do
    render

    assert_select "form[action=?][method=?]", moderate_tasks_path, "post" do

      assert_select "input[name=?]", "moderate_task[type]"

      assert_select "input[name=?]", "moderate_task[model_type]"

      assert_select "input[name=?]", "moderate_task[model_id]"

      assert_select "input[name=?]", "moderate_task[creator]"

      assert_select "input[name=?]", "moderate_task[passer]"
    end
  end
end
