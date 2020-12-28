require "rails_helper"

RSpec.describe Customer, type: :model do
  context "on validation" do
    let(:customer){ build(:customer) }
    it "has many deliveries" do
      expect(Customer.reflect_on_association(:deliveries).macro).to eq :has_many
    end
    it "is valid" do
      expect(customer).to be_valid
    end
    it "is invalid without first_name" do
      customer.first_name = ""
      expect(customer).to be_invalid
    end
    it "is invalid without first_name_kana" do
      customer.first_name_kana = ""
      expect(customer).to be_invalid
    end
    it "is invalid without last_name" do
      customer.last_name = ""
      expect(customer).to be_invalid
    end
    it "is invalid without last_name_kana" do
      customer.last_name_kana = ""
      expect(customer).to be_invalid
    end
    it "is invalid without postcode" do
      customer.postcode = ""
      expect(customer).to be_invalid
    end
    it "is invalid without address" do
      customer.address = ""
      expect(customer).to be_invalid
    end
    it "is invalid without tel" do
      customer.tel = ""
      expect(customer).to be_invalid
    end
  end
  context "on validation after customer is made" do
    let(:customer){ create(:customer) }
    let(:item1){ create(:item1, category: category1) }
    let(:category1){ create(:category1) }
    let(:category2){ create(:category2) }
    let(:item2){ create(:item2, category: category2) }
    before do
      @cart_item1 = customer.cart_items.create(amount: 3, item: item1)
      @cart_item2 = customer.cart_items.create(amount: 2, item: item2)
    end
    it "has many cart_items" do
      expect(Customer.reflect_on_association(:cart_items).macro).to eq :has_many
    end
    it "can calc subtotal for all cart items" do
      expect(customer.subtotal_with_all_cart_items).to eq 3520
    end
  end
end