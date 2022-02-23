require 'rails_helper'

RSpec.describe "private_threads/new", type: :view do
  before(:each) do
    assign(:private_thread, PrivateThread.new(
      user1_id: "",
      user2_id: ""
    ))
  end

  it "renders new private_thread form" do
    render

    assert_select "form[action=?][method=?]", private_threads_path, "post" do

      assert_select "input[name=?]", "private_thread[user1_id]"

      assert_select "input[name=?]", "private_thread[user2_id]"
    end
  end
end
