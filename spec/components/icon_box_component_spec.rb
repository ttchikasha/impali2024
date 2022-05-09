# frozen_string_literal: true

require "rails_helper"

RSpec.describe IconBoxComponent, type: :component do
  pending "add some examples to (or delete) #{__FILE__}"

  it "renders something useful" do
    expect(
      render_inline(described_class.new(title: "Honesty", description: "Some Honesty Lines", icon: "box")).css("h4.title").to_html
    ).to include(
      "Honesty"
    )
  end
end
