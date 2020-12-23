require "rails_helper"

RSpec.describe "Header", type: :system do
  context "on header" do
    it "has link to about" do
      expect(page).to have_link "About", href: about_path
    end
  end
end