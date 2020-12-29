require "rails_helper"

RSpec.describe Order, type: :model do
  let(:customer){ create(:customer) }
  let(:order){ build(:order, customer_id: customer.id) }
  let(:category1){ create(:category1) }
  let(:category2){ create(:category2) }
  let(:item1){ create(:item1) }
  let(:item2){ create(:item2) }
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
    it "can set order_items by cart_items" do
      customer.cart_items.create(item: item1, amount: 3)
      customer.cart_items.create(item: item2, amount: 2)
      order_items = order.set_order_items(customer)
      order_items.each do |order_item|
        customer_cart_items.each do |cart_item|
          expect(order_item.item.id).to eq cart_item.item.id
          expect(order_item.amount).to eq cart_item.amount
        end
      end
    end
  end
end