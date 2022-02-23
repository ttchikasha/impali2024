require 'rails_helper'

RSpec.describe "classroom_subjects/show", type: :view do
  before(:each) do
    @classroom_subject = assign(:classroom_subject, ClassroomSubject.create!(
      subject: nil,
      classroom: nil,
      teacher_id: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
