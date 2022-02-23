require 'rails_helper'

RSpec.describe "private_threads/edit", type: :view do
  before(:each) do
    @private_thread = assign(:private_thread, PrivateThread.create!(
      user1_id: "",
      user2_id: ""
    ))
  end

  it "renders the edit private_thread form" do
    render

    assert_select "form[action=?][method=?]", private_thread_path(@private_thread), "post" do

      assert_select "input[name=?]", "private_thread[user1_id]"

      assert_select "input[name=?]", "private_thread[user2_id]"
    end
  end
end
