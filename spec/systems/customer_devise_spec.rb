require "rails_helper"

RSpec.describe "customer-devise-page", type: :system do
  context "on new sesison page" do
    let(:customer){ create(:customer) }
    it "has field for email" do
      expect(page).to have_field "customer[email]"
    end
    it "has field for password" do
      expect(page).to have_field "customer[password]"
    end
    it "has button to submit" do
      expect(page).to have_button "ログイン"
    end
    it "succeeds to login" do
      fill_in "customer[email]", with: customer.email
      fill_in "customer[password]", with: customer.password
      click_button "ログイン"
      expect(page).to have_content "successfully"
    end
    it "fails to login" do
      click_button "ログイン"
      expect(page).to have_content "error"
    end
    it "has link to register" do
      expect(page).to have_link "こちら", href: new_customer_registration_path
    end
  end
  context "on new registratoin page" do
    it "has first_name_field" do
      expect(page).to have_field "customer[first_name]"
      expect(page).to have_field "customer[first_name_kana]"
    end
    it "has last_name_field" do
      expect(page).to have_field "customer[last_name]"
      expect(page).to have_field "customer[last_name_kana]"
    end
    it "has field for email" do
      expect(page).to have_field "customer[email]"
    end
    it "has field for postcode" do
      expect(page).to have_field "customer[postcode]"
    end
    it "has field for address" do
      expect(page).to have_field "customer[address]"
    end
    it "has field for tel" do
      expect(page).to have_Field "customer[tel]"
    end
    it "has field for password" do
      expect(page).to have_field "customer[password]"
    end
    it "has field for password_confirmation" do
      expect(page).to have_field "customer[password_confirmation]"
    end
    it "has button to submit" do
      expect(page).to have_button "新規登録"
    end
    it "succceeds to register" do
      fill_in "customer[last_name]", with: "岸"
      fill_in "customer[first_name]", with: "優"
      fill_in "customer[email]", with: "yuki@com"
      flll_in "customer[postcode]", with: "5200815"
      fill_in "customer[address]", with: "滋賀県"
      fill_in "customer[tel]", with: "01234567890"
      fill_in "customer[password]", with: "testtest"
      fill_in "customer[password_confirmation]", with: "testtest"
      expect{ click_button "新規登録" }.to change{ Customer.all.count }.by(1)
      expect(page).to have_content "successfully"
    end
    it "fails to register" do
      click_button "新規登録"
      expect(page).to have_content "error"
    end
  end
end