require "rails_helper"

RSpec.describe CartItem, type: :model do
    let(:customer){ create(:customer) }
    let(:category1){ create(:category1) }
    let(:item1){ create(:item1, category: category1) }
    context "on validation" do
        let(:cart_item){ build(:cart_item, customer: customer, item: item1) }
        it "belongs_to customer" do
            expect(CartItem.reflect_on_association(:customer).macro).to eq :belongs_to
        end
        it "calc subtotal price" do
            expect(cart_item.subtotal).to eq 3300
        it "belongs_to item" do
            expect(CartItem.reflect_on_association(:item).macro).to eq :belongs_to
        end
        it "is valid" do
            expect(cart_item).to be_valid
        end
        it "is invalid withoud amount" do
            cart_item.amount = ""
            expect(cart_item).to be_invalid
        end
    end
end