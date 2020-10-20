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
end
