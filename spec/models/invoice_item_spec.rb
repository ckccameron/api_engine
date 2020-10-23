require 'rails_helper'

describe InvoiceItem, type: :model do
  it "exists with attributes" do
    attrs = {
      item_id: 963,
      invoice_id: 33,
      quantity: 2,
      unit_price: 30323,
      created_at: "2012-03-27 14:54:11 UTC",
      updated_at: "2012-03-27 14:54:11 UTC"
    }

    invoice_item = InvoiceItem.new(attrs)

    expect(invoice_item).to be_a InvoiceItem
    expect(invoice_item.item_id).to eq(963)
    expect(invoice_item.invoice_id).to eq(33)
    expect(invoice_item.quantity).to eq(2)
    expect(invoice_item.unit_price).to eq(30323)
    expect(invoice_item.created_at).to eq("2012-03-27 14:54:11 UTC")
    expect(invoice_item.updated_at).to eq("2012-03-27 14:54:11 UTC")
  end

  describe "validations" do
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:invoice_id) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
  end

  describe "relationships" do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end
end
