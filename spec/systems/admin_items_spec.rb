require "rails_helper"

RSpec.describe "admin-items page", type: :system do
  let(:admin){ create(:admin) }
  before do
    login_admin admin
  end
  context "on index page" do
    let(:category1){ create(:category1) }
    let(:item1){ create(:item1, category: category1) }
    let(:item2){ create(:item2, category: category1) }
    let(:item3){ create(:item3, category: category1) }
    before do
      visit admins_items_path
    end
    it "has items_table" do
      Item.all.each do |item|
        expect(page).to have_content item.id
        expect(page).to have_link item.name, href: admins_item_path(item)
        expect(page).to have_content item.price
        expect(page).to have_content item.category.name
        expect(page).to have_content item.status
      end
    end
    it "has link to new" do
      expect(page).to have_link "", href: new_admins_item_path
    end
  end
  context "on show page" do
    let(:category1){ create(:category1) }
    let(:item1){ create(:item1, category: category1) }
    before do
      visit admins_item_path(item1)
    end
    it "has item_name" do
      expect(page).to have_content item1.name
    end
    it "has item_description" do
      expect(page).to have_content item1.description
    end
    it "has item_category" do
      expect(page).to have_content item1.category.name
    end
    it "has item_price" do
      expect(page).to have_content item1.price
    end
    it "has item_status" do
      expect(page).to have_content item1.status
    end
    it "has button to edit" do
      expect(page).to have_link "編集する", href: edit_admins_item_path(item1)
    end
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
    let(:category1){ create(:category1) }
    let(:item1){ create(:item1, category: category1) }
    before do
      visit edit_admins_item_path(item1)
    end
    it "has image_field" do
      expect(page).to have_field "item[image]", with: item1.image
    end
    it "has name_field" do
      expect(page).to have_field "item[name]", with: item1.name
    end
    it "has description_field" do
      expect(page).to have_field "item[description]", with: item1.description
    end
    it "has category_field" do
      expect(page).to have_select("item[category]", options: Category.active, selected: item1.category)
    end
    it "has price_field" do
      expect(page).to have_price("item[price]"), with: item.price
    end
    it "has select_field for status" do
      expect(page).to have_select("item[is_active]", options: ["販売中", "販売中止"], selected: item1.status)
    end
    it "can update" do
      attach_file "item[image]", "#{ Rails.root }/spec/factories/noimage.jpg"
      fill_in "item[name]", with: "タルト"
      fill_in "item[description]", with: "れいれい"
      select "焼き菓子", from: "item[category]"
      fill_in "item[price]", with: "800"
      select "販売中止", from: "item[is_active]"
      click_button "変更を保存する"
      expect(page).to have_content "succeessfully"
      expect(current_path).to eq admins_item_path(item1)
      expect(page).to have_content "タルト"
      expect(page).to have_content "れいれい"
      expect(page).to have_content "800"
    end
    ot "fails to update" do
      fill_in "item[name]", with: ""
      click_button "変更を保存する"
      expect(page).to have_content "エラー"
    end
  end
end