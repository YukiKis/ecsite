require "rails_helper"

RSpec.describe "delivery-page", type: :system do
  let(:customer){ create(:customer) }
  before do
    login customer
  end
  context "on index / new page" do
    let(:delivery){ create(:delivery, customer: customer) }
    before do
      visit deliveries_path
    end
    it "has form for delivery" do
      expect(page).to have_field "delivery[postcode]"
      expect(page).to have_field "delivery[address]"
      expect(page).to have_field "delivery[name]"
      expect(page).to have_button "登録する"
    end
    it "has table for deliveries" do
      visit current_path
      # check by each
      customer.deliveries.each do |delivery|
        expect(page).to have_content delivery.postcode
        expect(page).to have_content delivery.addreses
        expect(page).to have_content delivery.name
        expect(page).to have_link "編集する", href: edit_delivery_path(delivery)
        expect(page).to have_link "削除する", href: delivery_path(delivery)
      end
      # check by actual"
      expect(page).to have_content "5200815"
      expect(page).to have_content "滋賀県"
      expect(page).to have_content "母"
      expect(page).to have_link "編集する", href: edit_delivery_path(delivery)
      expect(page).to have_link "削除する", href: delivery_path(delivery)
    end
    it "succeeds to make new delivery" do
      fill_in "delivery[postcode]", with: "1520003"
      fill_in "delivery[address]", with: "東京都"
      fill_in "delivery[name]", with: "俺"
      expect{ click_button("登録する") }.to change{ Delivery.all.count }.by(1)
      expect(page).to have_content "successfully"
    end
    it "fails to make" do
      click_button "登録する"
      expect(page).to have_content "エラー"
    end
  end
  context "on edit page" do
    let(:delivery){ create(:delivery, customer: customer) }
    before do
      visit edit_delivery_path(delivery)
    end
    it "has form for delivery" do
      expect(page).to have_field "delivery[postcode]", with: delivery.postcode
      expect(page).to have_field "delivery[address]", with: delivery.address
      expect(page).to have_field "delivery[name]", with: delivery.name
      expect(page).to have_button "編集する"
    end
    it "succeeds to udpate" do
      fill_in "delivery[postcode]", with: "1520003"
      fill_in "delivery[address]", with: "東京都"
      fill_in "delivery[name]", with: "俺"
      click_button "編集する"
      expect(current_path).to eq deliveries_path
      expect(page).to have_content "successfully"
    end
    it "fails to update" do
      fill_in "delivery[postcode]", with: ""
      click_button "編集する"
      expect(page).to have_content "エラー"
    end
  end
end