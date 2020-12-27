require "rails_helper"

RSpec.describe Item, type: :model do
  let(:category1){ create(:category1) }
  let(:item1){ build(:item1, category: category1) }
  context "on validation" do
    it "belongs_to category" do
      expect(Item.reflect_on_association(:category).macro).to eq :belongs_to
    end
    it "can calc tax_price" do
      expect(item1.price_with_tax).to eq 1100
    end
    it "is valid" do
      expect(item1).to be_valid
    end
    it "is invalid without image_id" do
      item1.image_id = ""
      expect(item1).to be_invalid
    end
    it "is invalid without name" do
      item1.name = ""
      expect(item1).to be_invalid
    end
    it "is invalid without description" do
      item1.description = ""
      expect(item1).to be_invalid
    end
    it "is invalid without price" do
      item1.price = ""
      expect(item1).to be_invalid
    end
  end
end