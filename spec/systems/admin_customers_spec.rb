require "rails_helper"

RSpec.describe "admin-customers page", type: :system do
  let(:admin){ create(:admin) }
  let(:customer){ create(:customer) }
  before do
    login_admin admin
  end
  context "on index page" do
    before do
      visit admins_customers_path
    end
    it "has customer table" do
      Customer.all.each do |customer|
        expect(page).to have_content customer.id
        expect(page).to have_link customer.name, href: admins_customer_path(customer)
        expect(page).to have_content customer.email
        expect(page).to have_content customer.status
      end
    end    
  end
  context "on show page" do
    before do
      visit admins_customer_path(customer)
    end
  end
  context "on edit page" do
    before do
      visit edit_admins_customer_path(customer)
    end
    it "has customer_id" do
      expect(page).to have_content custoemr.id
    end
    it "has name_Form" do
      expect(page).to have_field "customer[last_name]", with: customer.last_name
      expect(page).to have_field "customer[first_name]", with: customer.first_name
    end
    it "has kana_name_form" do
      expect(page).to have_field "customer[last_name_kana]", with: customer.last_name_kana
      expect(page).to have_field "customer[first_name_kana]", with: customer.first_name_kana
    end
    it "has postcode_form" do
      expect(page).to have_field "customer[postcode]", with: customer.postcode
    end
    it "has address_form" do
      expect(page).to have_field "customer[address]", with: customer.address
    end
    it "has tel_form" do
      expect(page).to have_field "customer[tel]", with: customer.tel
    end
    it "has email_form" do
      expect(page).to have_fild "customer[email]", with: customer.email
    end
    it "has radiobutton for axtive" do
      expect(page).to have_field "#customer_is_active_true"
      expect(page).to have_field "#customer_is_active_false"
    end
    it "succeeds to update" do
      fill_in "customer[last_name]", with: "一"
      fill_in "customer[first_name]", with: "那"
      fill_in "customer[last_name_kana]", with: "いち"
      fill_in "customer[first_name_kana]", with: "な"
      fill_in "customer[postcode]", with: "1520003"
      fill_in "customer[address]", with: "東京都"
      fill_in "customer[tel]", with: "123455678"
      fill_in "customer[email]", with: "ichi@com"
      choose "退会済み"
      click_button "変更を保存する"
      expect(current_path).to eq admins_customer_path(customer)
      expect(page).to have_content "successfully"
    end
    it "fails to update" do
      fill_in "customer[last_name]", with: ""
      click_button "変更を保存する"
      expect(page).to have_content "エラー"
    end
  end
    
end