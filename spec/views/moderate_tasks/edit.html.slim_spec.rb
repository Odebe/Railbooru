require 'rails_helper'

RSpec.describe "moderate_tasks/edit", type: :view do
  before(:each) do
    @moderate_task = assign(:moderate_task, ModerateTask.create!(
      :type => "",
      :model_type => "",
      :model_id => "",
      :creator => "",
      :passer => ""
    ))
  end

  it "renders the edit moderate_task form" do
    render

    assert_select "form[action=?][method=?]", moderate_task_path(@moderate_task), "post" do

      assert_select "input[name=?]", "moderate_task[type]"

      assert_select "input[name=?]", "moderate_task[model_type]"

      assert_select "input[name=?]", "moderate_task[model_id]"

      assert_select "input[name=?]", "moderate_task[creator]"

      assert_select "input[name=?]", "moderate_task[passer]"
    end
  end
end
