require "rails_helper"

RSpec.describe Delivery, type: :model do
  let(:customer){ create(:customer) }
  let(:delivery){ build(:delivery, customer_id: customer.id ) }
  context "on validation" do
    it "is valid" do
      expect(delivery).to be_valid
    end
    it "is invalid without customer_id" do
      customer.id = ""
      expect(delivery).to be_invalid
    end
    it "is invalid without postcode" do
      delivery.postcode = ""
      expect(delivery).to be_invalid
    end
    it "is invalid without address" do
      delivery.address = ""
      expect(delivery).to be_invalid
    end
    it "is invalid without name" do
      delivery.name = ""
      expect(delivery).to be_invalid
    end
    it "belongs to customer" do
      expect(Delivery.reflect_on_association(:customer).macro).to eq :belongs_to
    end
  end
end