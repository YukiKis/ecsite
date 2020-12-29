require "rails_helper"

RSpec.describe "admin-items page", type: :system do
  let(:admin){ create(:admin) }
  before do
    login_admin admin
  end
  context "on index page" do
  end
  context "on show page" do
  end
  context "on new page" do
    before do
      visit new_admins_item_path
    end
    it "has form for name" do
      expect(page).to have_field "item[name]"
    end
    it "has form for description" do
      expect(page).to have_field "item[description]"
    end
    it "has form for category" do
      expect(page).to have_select("item[category]", options: Category.active)
    end
    it "has form for price" do
      expect(page).to have_field "item[price]"
    end
    it "has form for is_active" do
      expect(page).to have_select("item[is_active", options: ["有効", "無効"])
    end
    it "has form for image" do
      expect(page).to have_field "item[image]"
    end
    it "has button for creating" do
      expect(page).to have_button "新規登録"
    end
    it "succeeds to create" do
      attach_file "item[image]", "#{ Rails.root }/spec/factories/noimage.jpg"
      fill_in "item[name]", with: "ケーキ"
      fill_in "item[description]", with: "例"
      select "ケーキ", from: "item[category]" 
      fil_in "itme[price]", with: "1000"
      select "有効", from: "item[is_active]"
      expect{ click_button "新規登録" }.to change{ Item.all.count }.by(1)
      expect(current_path).to eq admin_item_path(Item.all.last)
      expect(page).to have_content "successfully"
    end
    it "fails to create" do
      click_button "新規登録"
      expect(page).to have_content "エラー"
    end
  end
  context "on edit page" do
  end
end