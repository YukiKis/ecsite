require "rails_helper"

RSpec.describe "CartItems page", type: :system do
  let(:customer){ create(:customer) }
  let(:category1){ create(:category1) }
  let(:category2){ create(:category2) }
  let(:item1){ create(:item1, category: category1) }
  let(:item2){ create(:item2, category: category2) }
  before do
    login customer
    @cart_item1 = customer.cart_items.create(amount: 3, item: item1)
    @cart_item2 = customer.cart_items.create(amount: 2, item: item2)
  end
  context "on index page" do
    before do 
      visit cart_items_path
    end
    it "has button for clearing cart_items" do
      expect(page).to have_link "カートを空にする", href: destroy_all_cart_items_path
    end
    it "has successfully destroy all" do
      click_link "カートを空にする"
      expect(page).to have_content "All deleted"
      expect(page).not_to have_content item1.name
      expect(page).not_to have_content item2.name
    end
    it "has table for cart_items" do
      # check with each
      customer.cart_items.all.each do |cart_item|
        expect(page).to have_content cart_item.item.name
        expect(page).to have_content cart_item.item.price_with_tax.to_s(:delimited)
        expect(page).to have_field "cart_item[amount]", with: cart_item.amount
        expect(page).to have_button "変更"
        expect(page).to have_content cart_item.subtotal.to_s(:delimited)
        expect(page).to have_link "削除する", href: cart_item_path(cart_item)
      end
      #check with actual
    end
    #check with method
    it "has subtotal price for all included with method" do
      expect(page).to have_content customer.subtotal_with_all_cart_items.to_s(:delimited)
    end
    # check with actual
    it "has subtotal price for all included actual" do
      expect(page).to have_content "3,520"
    end
    it "can change amount of the cart_item" do
      fill_in "cart_item_amount_1", with: "10"
      click_button "変更"
      expect(page).to have_field "cart_item_amount_1", with: "10"
      expect(page).to have_content "11,000"
    end
    it "has button for next" do
      expect(page).to have_link "情報入力に進む", href: new_order_path
    end
    it "has button back to items_path" do
      expect(page).to have_link "買い物を続ける", href: items_path
    end

  end
end