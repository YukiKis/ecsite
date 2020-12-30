require "rails_helper"

RSpec.describe "admin-top", type: :system do
  let(:admin){ create(:admin) }
  context "on top page" do
    before do
      login_admin admin
    end
    it "has number of orders" do
      expect(page).to have_link "/\d+/件", admin_today_orders_path
    end
  end
  
end