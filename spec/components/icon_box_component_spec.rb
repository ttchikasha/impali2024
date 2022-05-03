# frozen_string_literal: true

require "rails_helper"

RSpec.describe IconBoxComponent, type: :component do
  pending "add some examples to (or delete) #{__FILE__}"

  it "renders something useful" do
    expect(
      render_inline(described_class.new(title: "Honesty")) { "Hello, components!" }.css("p").to_html
    ).to include(
      "Hello, components!"
    )
  end
end
