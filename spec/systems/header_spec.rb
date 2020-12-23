require "rails_helper"

RSpec.describe "Header", type: :system do
  context "on header when no login" do
    it "has link to top page" do
      expect(page).to have_link "LOGO", href: root_path
    end
    it "has link to about" do
      expect(page).to have_link "About", href: about_path
    end
    it "has link to item-index" do
      expect(page).to have_link "商品一覧", href: items_path
    end
    it "has link to login" do
      expect(page).to have_link "新規登録", href: new_customer_session_path
    end
    it "has link to register" do
      expect(page).to have_link "会員登録", href: new_customer_registration_path
    end
  end
  context "on header when logged in as customer" do
    let(:customer){ create(:customer) }
    it "has link to top page" do
      expect(page).to have_link "LOGO", href: root_path
    end
    it "has link to customer_show" do
      expect(page).to have_link "マイページ", href: customer_path
    end
    it "has link to item-index" do
      expect(page).to have_link "商品一覧", href: items_path
    end
#   it "has link to cartitems-index" do
#      expect(page).to have_link "カート", href
#   end
   it "has button to logout" do
     expect(page).to have_link "ログアウト", href: destroy_customer_session_path
   end
 end
end