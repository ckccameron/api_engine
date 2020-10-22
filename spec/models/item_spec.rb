require 'rails_helper'

describe Item, type: :model do
  it "exists with attributes" do
    attrs = {
      name: "Item Unde Id",
      description: "Voluptatum iste ad rem placeat iusto nulla. Qui dolore nostrum non amet illo voluptatem ut. Sunt mollitia id quis quas modi. Vero non corporis soluta eveniet voluptatem.",
      unit_price: 54001,
      merchant_id: 3,
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }

    item = Item.new(attrs)

    expect(item).to be_a Item
    expect(item.name).to eq("Item Unde Id")
    expect(item.description).to eq("Voluptatum iste ad rem placeat iusto nulla. Qui dolore nostrum non amet illo voluptatem ut. Sunt mollitia id quis quas modi. Vero non corporis soluta eveniet voluptatem.")
    expect(item.unit_price).to eq(54001)
    expect(item.merchant_id).to eq(3)
    expect(item.created_at).to eq("2012-03-27 14:53:59 UTC")
    expect(item.updated_at).to eq("2012-03-27 14:53:59 UTC")
  end

  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    # it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "class methods" do
    it ".find_single_item(param)" do
      merchant = create(:merchant)
      item = create(:item, name: "Basketball", merchant_id: merchant.id)
      param = {"name": "ball"}

      expect(Item.find_single_item(param)).to eq(item)
    end

    it ".find_all_items(param)" do
      merchant = create(:merchant)
      item1 = create(:item, name: "Basketball", merchant_id: merchant.id)
      item2 = create(:item, name: "Football", merchant_id: merchant.id)
      item3= create(:item, name: "Boxing Gloves", merchant_id: merchant.id)
      param = {"name": "ball"}

      expect(Item.find_all_items(param)).to eq([item1, item2])
      expect(Item.find_all_items(param)).to_not include(item3)
    end
  end
end
