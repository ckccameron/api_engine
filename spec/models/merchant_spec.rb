require 'rails_helper'

describe Merchant, type: :model do
  it "exists with attributes" do
    attrs = {
              name: "Williamson Group",
              created_at: "2012-03-27 14:53:59 UTC",
              updated_at: "2012-03-27 14:53:59 UTC"
            }
    merchant =  Merchant.new(attrs)

    expect(merchant).to be_a Merchant
    expect(merchant.name).to eq("Williamson Group")
    expect(merchant.created_at).to eq("2012-03-27 14:53:59 UTC")
    expect(merchant.updated_at).to eq("2012-03-27 14:53:59 UTC")
  end

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "class methods" do
    it ".find_single_merchant(param)" do
      merchant = create(:merchant, name: "The Shop")
      param = {"name": "sho"}

      expect(Merchant.find_single_merchant(param)).to eq(merchant)
    end

    it ".find_all_merchants(param)" do
      merchant1 = create(:merchant, name: "The Shop")
      merchant2 = create(:merchant, name: "Showtime")
      merchant3 = create(:merchant, name: "Shabooya!")
      param = {"name": "sho"}

      expect(Merchant.find_all_merchants(param)).to eq([merchant1, merchant2])
      expect(Merchant.find_all_merchants(param)).to_not include(merchant3)
    end
  end
end
