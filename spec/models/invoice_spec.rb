require 'rails_helper'

describe Invoice, type: :model do
  it "exists with attributes" do
    attrs = {
      customer_id: 14,
      merchant_id: 22,
      status: "shipped",
      created_at: "2012-03-12 10:54:13 UTC",
      updated_at: "2012-03-12 10:54:13 UTC"
    }

    invoice = Invoice.new(attrs)

    expect(invoice).to be_a Invoice
    expect(invoice.customer_id).to eq(14)
    expect(invoice.merchant_id).to eq(22)
    expect(invoice.status).to eq("shipped")
    expect(invoice.created_at).to eq("2012-03-12 10:54:13 UTC")
    expect(invoice.updated_at).to eq("2012-03-12 10:54:13 UTC")
  end

  describe "validations" do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:status) }
  end

  describe "relationships" do
    it { should belong_to(:customer) }
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    # it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end
end
