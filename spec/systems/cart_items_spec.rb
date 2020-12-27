require "rails_helper"

RSpec.describe "CartItems page", type: :system do
  let(:customer){ create(:customer) }
  let(:category1){ create(:category1) }
  let(:category2){ create(:category2) }
  let(:item1){ create(:item1, category: category1) }
  let(:item2){ create(:item2, category: category2) }
  before do
    login customer
  end
  context "on index page" do
    before do 
      visit cart_items_path
    end
    it "has button for clearing cart_items" do
      expect(page).to have_link "カートを空にする", href: destroy_all_cart_items_path
    end
    it "has table for cart_items" do
      # check with each
      customer.cart_items.all.each do |cart_item|
        expect(page).to have_content cart_item.item.name
        expect(page).to have_content cart_item.item.price_with_tax
        expect(page).to have_field "cart_item[amount]", with: cart_item.amount
        expect(page).to have_button "変更"
        expect(page).to have_content cart_item.subtotal
        expect(page).to have_link "削除する", href: cart_item_path
      end
      #check with actual
    end
    it "has subtotal price for all included" do
      expect(page).to have_content
  end
end