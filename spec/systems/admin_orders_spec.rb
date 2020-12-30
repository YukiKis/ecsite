require "rails_helper"

RSpec.describe "admin-orders page", type: :system do
  let(:admin){ create(:admin) }
  let(:category1){ create(:category1) }
  let(:category2){ create(:category2) }
  let(:item1){ create(:item1) }
  let(:item2){ create(:item2) }
  let(:customer){ create(:customer) }
  let(:order){ create(:order, customer: customer) }
  let(:order_item1){ create(:order_item, order: order, item: item1) }
  let(:order_item2){ create(:order_item, order: order, item: item2) }
  before do
    login_admin admin
  end
  context "on index page" do
    before do
      visit admins_orders_path
    end
    it "has order table" do
      Order.all.each do |order| 
        expect(page).to have_link order.created_at.strftime("%y/%m/%d %H:%M:%S"), href: admins_order_path(order)
        expect(page).to have_content order.custoemr.name
        expect(page).to have_content order.order_items.count
        expect(page).to have_content order.status
      end
    end
  end
  context "on show page" do
    before do
      visit admins_order_path(order)
    end
    it "has order_customer.name" do
      expect(page).to have_content order.customer.name
    end
    it "has delivery_place" do
      expect(page).to have_content order.postcode
      expect(page).to have_content order.address
      expect(page).to have_content order.name
    end
    it "has payment" do
      expect(page).to have_content order.payment
    end
    it "has order_status field" do
      expect(page).to have_select("order[status]", options: ["入金待ち", "作成中", "発送済み"])
      expect(page).to have_button "更新"
    end
    it "succeeds to update order_status" do
      select "作成中", from: "order[status]"
      click_button "更新"
      expect(page).to have_content "作成中"
    end
    it "has order_item table" do
      order.order_items.each do |order_item| 
        expect(page).to have_content order_item.item.name
        expect(page).to have_content order_item.item.price_with_tax
        expect(page).to have_content order_item.amount
        expect(page).to have_content order_item.subtotal
        expect(page).to have_select("order_item[status]", options["着手不可", "作成中", "作成済み"])
        expect(page).to have_button "更新"
      end
    end
    it "succeeds to change order_item_status" do
      select "作成済み", from: "order_item[status]"
      click_button "更新"
      expect(page).to have_content "作成済み"
    end
    it "has prices" do
      expect(page).to have_content order.subtotal_price
      expect(page).to have_content order.shipment
      expect(page).to have_content order.total_price
    end
  end
end