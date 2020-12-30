require "rails_helper"

RSpec.describe "admins-category-page", type: :system do
  let(:admin){ create(:admin) }
  let(:category1){ create(:category1) }
  let(:category2){ create(:category2) }
  before do
    login_admin admin
  end
  context "on index page" do
    before do
      visit admins_categories_path
    end
    it "has form for new category" do
      expect(page).to have_field "category[name]"
      expect(page).to have_field "有効"
      expect(page).to have_field "無効"
      expect(page).to have_button "追加"
    end
    it "has categories_list" do
      Category.all.each do |category| 
        expect(page).to have_content category.name
        expect(page).to have_content category.status
        expect(page).to have_link "編集する", href: edit_admins_category_path
      end
    end
    it "successfully create" do
      fill_in "category[name]", with: "例"
      choose "有効"
      expect{ click_button "追加" }.to change{ Category.all.count }.by(1)
      expect(page).to have_content "successfully"
    end
    it "fails to create" do
      click_button "追加"
      expect(page).to have_content "エラー"
    end
  end
  context "on edit page" do
    before do
      visit edit_admins_category_path(category1)
    end
    it "has name_field" do
      expect(page).to have_field "category[name]", with: category1.name
    end
    it "has category_status" do
      expect(page).to have_field "有効"
      expect(page).to have_field "無効"
    end
    it "has button for updating" do
      expect(page).to have_button "変更を保存する"
    end
    it "successfully update" do
      fill_in "category[name]", with: "しっぱい"
      choose "無効"
      click_button "変更を保存する"
      expect(page).to have_content "しっぱい"
      expect(page).to have_content "successfully"
    end
    it "fails to update" do
      fill_in "category[name]", with: ""
      click_button "変更を保存する"
      expect(page).to have_content "エラー"
    end
  end
end