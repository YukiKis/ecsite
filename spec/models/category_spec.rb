require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category1){ build(:category1) }
  context "on validation" do
    it "has_many items" do
      expect(Category.reflect_on_association(:items).macro).to eq :has_many
    end
    it "is valid" do
      expect(category1).to be_valid
    end
    it "is invalid without name" do
      category1.name = ""
      expect(category1).to be_invalid
    end
  end
  context "on method" do
    it "return status active" do
      expect(category1.status).to eq "有効"
    end
    it "return status inactive" do
      category1.is_active = false
      expect(category1.status).to eq "無効"
    end
  end
end