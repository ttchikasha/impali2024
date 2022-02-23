require 'rails_helper'

RSpec.describe "private_threads/show", type: :view do
  before(:each) do
    @private_thread = assign(:private_thread, PrivateThread.create!(
      user1_id: "",
      user2_id: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
