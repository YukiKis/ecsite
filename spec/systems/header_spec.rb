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
    before do
      login customer
    end
    it "has link to top page" do
      expect(page).to have_link "LOGO", href: root_path
    end
    it "has link to customer_show" do
      expect(page).to have_link "マイページ", href: customer_path
    end
    it "has link to item-index" do
      expect(page).to have_link "商品一覧", href: items_path
    end
   it "has link to cartitems-index" do
      expect(page).to have_link "カート", href: cart_items_path
   end
   it "has button to logout" do
     expect(page).to have_link "ログアウト", href: destroy_customer_session_path
   end
 end
 context "on header when logged in as admin" do
   let(:admin){ create(:admin) }
   before do
     login_admin admin
   end
   it "has link to admin_items" do
     expect(page).to have_link "商品一覧", href: admin_items_path
   end
   it "has link to admin_users" do
     expect(page).to havev_link "会員一覧", href: admin_users_path
   end
   it "has link_to admin_orders" do
     expect(page).to have_link "注文履歴一覧", href: admin_categories_path
   end
   it "has link_to logout" do
     expect(page).to have_link "ログアウト", with: destroy_admin_session_path
   end
 end
end