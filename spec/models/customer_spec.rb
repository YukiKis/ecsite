require "rails_helper"

RSpec.describe Customer, type: :model do
  context "on validation" do
    let(:customer){ build(:customer) }
    it "is valid" do
      expect(customer).to be_valid
    end
    it "is invalid without first_name" do
      customer.first_name = ""
      expect(customer).to be_invalid
    end
    it "is invalid without first_name_kana" do
      customer.first_name_kana = ""
      expect(customer).to be_invalid
    end
    it "is invalid without last_name" do
      customer.last_name = ""
      expect(customer).to be_invalid
    end
    it "is invalid without last_name_kana" do
      customer.last_name_kana = ""
      expect(customer).to be_invalid
    end
    it "is invalid without postcode" do
      customer.postcode = ""
      expect(customer).to be_invalid
    end
    it "is invalid without address" do
      customer.address = ""
      expect(customer).to be_invalid
    end
    it "is invalid without tel" do
      customer.tel = ""
      expect(customer).to be_invalid
    end
  end
end