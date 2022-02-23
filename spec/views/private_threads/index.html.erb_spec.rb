require 'rails_helper'

RSpec.describe "private_threads/index", type: :view do
  before(:each) do
    assign(:private_threads, [
      PrivateThread.create!(
        user1_id: "",
        user2_id: ""
      ),
      PrivateThread.create!(
        user1_id: "",
        user2_id: ""
      )
    ])
  end

  it "renders a list of private_threads" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
