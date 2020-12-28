require "rails_helper"

RSpec.describe Order, type: :model do
  let(:customer){ create(:customer) }
  let(:order){ build(:order, customer_id: customer.id) }
  context "on validation" do
    it "has many order_items" do
      expect(Order.reflect_on_association(:order_items).macro).to eq :has_many
    end
    it "belongs_to customer" do
      expect(Order.reflect_on_association(:customer).macro).to eq :belongs_to
    end
    it "is valid" do
      expect(order).to be_valid
    end
    it "is invalid without payment" do
      order.payment = ""
      expect(order).to be_invalid
    end
    it "is invalid without postcode" do
      order.postcode = ""
      expect(order).to be_invalid
    end
    it "is invalid without address" do
      order.address = ""
      expect(order).to be_invalid
    end
    it "is invalid without name" do
      order.name = ""
      expect(order).to be_invalid
    end
    it "is invalid without shipment" do
      order.shipment = ""
      expect(order).to be_invalid
    end
  end
end