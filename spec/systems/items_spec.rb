require "rails_helper"

RSpec.describe "items-page", type: :system do
  let(:customer){ create(:customer) }
  let(:category1){ create(:category1) }
  let(:category2){ create(:category2) }
  let(:category3){ create(:category3) }
  let(:category4){ create(:category4) }
  let(:item1){ create(:item1, category: category1) }
  let(:item2){ create(:item2, category: category2) }
  let(:item3){ create(:item3, category: category3) }
  let(:item4){ craete(:item4, category: category4) }
  before do
    login customer
  end
  context "on index page" do
    before do
      visit items_path
    end
    it "has category_list" do
      # check with each
      Category.all.each do |c|
        expect(page).to have_link c.name, href: categorized_items(c)
      end
      expect(page).to have_link "ケーキ", href: categorized_items_path(category1)
     expect(page).to have_link "焼き菓子", href: categorized_items_path(category2)
      expect(page).to have_link "プリン", href: categorized_items_path(category3)
      expect(page).to have_link "キャンディ", href: categorized_items_path(category4)
    end
    it "has item_count" do
      # check with actual number
      expect(page).to have_content "4"
      # check with using all.count
      expect(page).to have_content Item.active.count
    end
    it "has link for show" do
      Item.active.each do |item|
        expect(page).to have_link "", href: item_path(item)
      end
    end
    it "has name and price for item" do
      Item.active.each do |item|
        expect(page).to have_content item.name
        expect(page).to have_content item.price
      end
    end
  end
  context "on show page" do
    before do
      visit item_path(item1)
    end
    it "has category_list" do
      # check with each
      Category.all.each do |c|
#        expect(page).to have_link c.name, href:
      end
#      expect(page).to have_link "ケーキ", href: 
#      expect(page).to have_link "焼き菓子", href:
#      expect(page).to have_link "プリン", href: 
#      expect(page).to have_link "キャンディ", href:
    end
    it "has item image" do
      expect(page).to have_css "#item-image-#{ item1.id }"
    end
    it "has item name" do
      expect(page).to have_content item1.name
    end
    it "has item description" do
      expect(page).to have_content item1.description
    end
    it "has item price with tax" do
      expect(page).to have_content item1.price_with_tax
    end
    it "has select form for number of items to buy" do
      expect(page).to have_select("cart_item_amount", options: [1, 2, 3, 4, 5])
      expect(page).to have_button "カートに入れる"
    end
  end
end