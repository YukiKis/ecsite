require "rails_helper"

RSpec.describe "customer-pages", type: :system do
  let(:customer){ create(:customer) }
  before do
    login customer
  end
  context "on show page" do
    before do
      visit customer_path
    end
    it "has link to edit" do
      expect(page).to have_link "編集する", href: edit_customer_path
    end
    it "has link to change password" do
      expect(page).to have_link "パスワードを変更する", href: edit_customer_password_path
    end
    it "has table for customer info" do
      expect(page).to have_content customer.last_name
      expect(page).to have_content customer.first_name
      expect(page).to have_content customer.last_name_kana
      expect(page).to have_content customer.first_name_kana
      expect(page).to have_content customer.postcode
      expect(page).to have_content customer.address
      expect(page).to have_content customer.tel
      expect(page).to have_content customer.email
    end
    it "has link to delivery_index" do
      expect(page).to have_link "一覧を見る", href: deliveries_path
    end
    it "has link to order-index" do
      expect(page).to have_link "一覧を見る", href: orders_path
    end
  end
  context "on edit page" do
    before do
      visit edit_customer_path
    end
    it "has form for name" do
      expect(page).to have_field "customer[last_name]", with: customer.last_name
      expect(page).to have_field "customer[first_name]", with: customer.first_name
    end
    it "has form for kana" do
      expect(page).to have_field "customer[last_name_kana]", with: customer.last_name_kana
      expect(page).to have_field "customer[first_name_kana]", with: customer.first_name_kana
    end
    it "has form for email" do
      expect(page).to have_field "customer[email]", with: customer.email
    end
    it "has form for postcode" do
      expect(page).to have_field "customer[postcode]", with: customer.postcode
    end
    it "has form for address" do
      expect(page).to have_field "customer[address]", with: customer.address
    end
    it "has form for tel" do
      expect(page).to have_field "customer[tel]", with: customer.tel
    end
    it "succeeds to udpate" do
      fill_in "customer[last_name]", with: "市"
      fill_in "customer[first_name]", with: "那"
      fill_in "customer[last_name_kana]", with: "イチ"
      fill_in "customer[first_name_kana]", with: "ナ"
      fill_in "customer[email]", with: "ichi@com"
      fill_in "customer[postcode]", with: "5248585"
      fill_in "customer[address]", with: "守山"
      fill_in "customer[tel]", with: "09876543210"
      click_button "編集内容を保存する"
      expect(current_path).to eq customer_path
      expect(page).to have_content "successfully"
    end
    it "fails to udpate" do
      fill_in "customer[first_name]", with: ""
      click_button "編集内容を保存する"
      expect(page).to have_content "エラー"
    end
    it "has button to quit" do
      expect(page).to have_link "退会する", href: quit_customer_path
    end
  end
  context "on quit" do
    before do
      visit quit_customer_path
    end
    it "has button to go back to edit" do
      expect(page).to have_link "退会しない", href: edit_customer_path
      expect(page).to have_link "退会する", href: leave_customer_path
    end
    it "succeeds to leave" do
      click_link "退会する"
      customer.reload
      expect(customer.is_active).to eq false
      expect(current_path).to eq root_path
    end
  end
end