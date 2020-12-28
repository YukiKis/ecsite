require "rails_helper"

RSpec.describe "Order page" do
  let(:customer){ create(:customer) }
  let(:category1){ create(:category1) }
  let(:item1){ create(:item1, category: category1) }
  let(:category2){ create(:category2) }
  let(:item2){ create(:item2, category: category2) }
  before do
    login customer
    @cart_item1 = customer.cart_items.create(item: item1, amount: 3)
    @cart_item2 = customer.cart_items.create(item: item2, amount: 2)
  end
  context "on index page" do
    before do
      let(:order){ create(:order, customer: customer) }
      order.set_order_items(customer)
      visit orders_path
    end
    it "has orders list" do
      customer.orders.each do |order|
        expect(page).to have_content order.created_at.to_strftime("%Y/%m/%d")
        expect(page).to have_content order.postcode
        expect(page).to have_content order.address
        expect(page).to have_content order.name
        order.order_items.each do |order_item|
          expect(page).to have_content order_item.item.name
        end
        expect(page).to have_content order.total_price.to_s(:delimited)
        expect(page).to have_content order.status
        expect(page).to have_link "表示する", order_path(order)
      end
    end
  end
  context "on show page" do
    before do
      let(:order){ create(:order, customer: customer) }
      order.set_order_items(customer)
      visit order_path(order)
    end    
    it "has order info" do
      expect(page).to have_content order.create_at.strftime("%Y/%m/%d")
      expect(page).to have_content order.postcode
      expect(page).to have_cotnent order.address
      expect(page).to have_content order.name
      expect(page).to have_content order.payment
      expect(page).to have_content order.status
    end
    it "has order price" do
      expect(page).to have_content customer.subtotal_with_all_cart_items.to_s(:delimited)
      expect(page).to have_content order.shipment.to_s(:delimited)
      expect(page).to have_content order.total_price.to_s(:delimited)
    end
    it "has order_item info" do
      order.order_items.each do |order_item|
        expect(page).to have_content order_item.item.name
        expect(page).to have_content order_item.item.order_with_tax
        expect(page).to have_content order_item.amount
        expect(page).to have_content order_item.subtotal
      end
    end
  end
  
  context "on new page" do
    before do
      visit new_order_path
    end
    it "has radiobutton for payment" do
      expect(page).to have_field "クレジットカード"
      expect(page).to have_field "銀行振込"
    end
    it "has radiobutton for address" do
      expect(page).to have_field "ご自身の住所"
      expect(page).to have_field "登録済み住所から選択"
      expect(page).to have_field "新しい届け先"
    end
    it "has own postcode and address" do
      expect(page).to have_content customer.postcode
      expect(page).to have_content customer.address
    end
    it "has select form for selecting registered address" do
      expect(page).to have_select("info[registered_address", options: customer.deliveries.all.map{ |d| "#{ d.postcode } #{ d.address } #{ d.name }" })
    end
    it "has form for new delivery" do
      expect(page).to have_field "郵便番号(ハイフンなし)"
      expect(page).to have_field "住所"
      expect(page).to have_field "宛名"
    end
    it "has button to go to check page" do
      expect(page).to have_button "確認画面へ進む"
    end
  end
  context "on check page" do
    before do
      visit new_order_path
      choose "クレジットカード"
      choose "ご自身の住所"
      click_button "確認画面へ進む"
    end
    it "has item info" do
      # check with each
      customer.cart_items.each do |cart_item|
        expect(page).to have_content cart_item.name
        expect(page).to have_content cart_item.item.price_with_tax.to_s(:delimited)
        expect(page).to have_content cart_item.amount
        expect(page).to have_content cart_item.subtotal.to_s(:delimited)
      end
      # check with actual
    end
    it "has payment" do
      expect(page).to have_content "クレジットカード"
    end
    it "has delivery-place" do
      expect(page).to have_content customer.postcode
      expect(page).to have_content customer.address
      expect(page).to have_content "#{ customer.last_name }#{ customer.first_name }"
    end
    it "has price for shipment" do
      expect(page).to have_content "800"
    end
    it "has subtotal for all item" do
      expect(page).to have_content customer.cart_items.inject(0){ |result, cart_item| result += cart_item.subtotal }
    end
    it "has total price" do
      expect(page).to have_content (customer.cart_items.inject(0) do |result, cart_item|
        result += cart_item.subtotal
      end + 800).to_s(:delimited)
    end
    it "has button for creating order" do
      expect(page).to have_button "購入を確定する"
    end
  end
end