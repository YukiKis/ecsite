require "rails_helper"

RSpec.describe OrderItem, type: :model do
  let(:category1){ create(:ategory1) }
  let(:item1){ create(:item1, category: category1) }
  let(:customer){ create(:customer) }
  let(:order){ create(:order, customer: customer) }
  before do
    @order_item1 = order.order_items.create(item: item1)
  end
  context "on validation" do
    it "belongs_to order" do
      expect(OrderItem.reflect_on_association(:order).macro).to eq :belongs_to
    end
    it "belongs_to item" do
      expect(OrderItem.reflect_on_association(:item).macro).to eq :belongs_to
    end
    it "is valid" do
      expec(order_item1).to be_valid
    end
    it "is invalid without amount" do
      order_item1.amount = ""
      expect(order_item1).to be_invalid
    end
  end
end