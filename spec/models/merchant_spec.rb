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

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
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

    it ".most_revenue(quantity)" do
      customer = create(:customer)

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      item3 = create(:item, merchant: merchant3)

      invoice1 = Invoice.create(customer: customer, merchant: merchant1, status: "shipped")
      invoice2 = Invoice.create(customer: customer, merchant: merchant2, status: "shipped")
      invoice3 = Invoice.create(customer: customer, merchant: merchant2, status: "shipped")
      invoice4 = Invoice.create(customer: customer, merchant: merchant3, status: "shipped")
      invoice5 = Invoice.create(customer: customer, merchant: merchant3, status: "shipped")

      item_invoice1 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 15, unit_price: item1.unit_price)
      item_invoice2 = InvoiceItem.create(item: item2, invoice: invoice2, quantity: 7, unit_price: item2.unit_price)
      item_invoice3 = InvoiceItem.create(item: item2, invoice: invoice3, quantity: 5, unit_price: item2.unit_price)
      item_invoice4 = InvoiceItem.create(item: item3, invoice: invoice4, quantity: 8, unit_price: item3.unit_price)
      item_invoice5 = InvoiceItem.create(item: item3, invoice: invoice5, quantity: 4, unit_price: item3.unit_price)

      transaction1 = Transaction.create(invoice: invoice1, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
      transaction2 = Transaction.create(invoice: invoice2, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
      transaction3 = Transaction.create(invoice: invoice3, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
      transaction4 = Transaction.create(invoice: invoice4, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
      transaction5 = Transaction.create(invoice: invoice5, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")

      quantity = 2

      expect(Merchant.most_revenue(quantity)).to eq([merchant1, merchant2])
      expect(Merchant.most_revenue(quantity)).to_not include(merchant3)
    end

    it ".most_items_sold(quantity)" do
      customer1 = create(:customer)
      customer2 = create(:customer)

      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      merchant4 = create(:merchant)

      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      item3 = create(:item, merchant: merchant3)
      item4 = create(:item, merchant: merchant4)

      invoice1 = Invoice.create(customer: customer1, merchant: merchant1, status: "shipped")
      invoice2 = Invoice.create(customer: customer1, merchant: merchant2, status: "shipped")
      invoice3 = Invoice.create(customer: customer2, merchant: merchant2, status: "shipped")
      invoice4 = Invoice.create(customer: customer1, merchant: merchant3, status: "shipped")
      invoice5 = Invoice.create(customer: customer2, merchant: merchant3, status: "shipped")
      invoice6 = Invoice.create(customer: customer2, merchant: merchant3, status: "shipped")
      invoice7 = Invoice.create(customer: customer1, merchant: merchant4, status: "shipped")
      invoice8 = Invoice.create(customer: customer1, merchant: merchant4, status: "shipped")
      invoice9 = Invoice.create(customer: customer2, merchant: merchant4, status: "shipped")
      invoice10 = Invoice.create(customer: customer2, merchant: merchant4, status: "shipped")

      item_invoice1 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 2, unit_price: item1.unit_price)
      item_invoice2 = InvoiceItem.create(item: item2, invoice: invoice2, quantity: 1, unit_price: item2.unit_price)
      item_invoice3 = InvoiceItem.create(item: item2, invoice: invoice3, quantity: 3, unit_price: item2.unit_price)
      item_invoice4 = InvoiceItem.create(item: item3, invoice: invoice4, quantity: 1, unit_price: item3.unit_price)
      item_invoice5 = InvoiceItem.create(item: item3, invoice: invoice5, quantity: 1, unit_price: item3.unit_price)
      item_invoice6 = InvoiceItem.create(item: item3, invoice: invoice6, quantity: 5, unit_price: item3.unit_price)
      item_invoice7 = InvoiceItem.create(item: item4, invoice: invoice7, quantity: 3, unit_price: item4.unit_price)
      item_invoice8 = InvoiceItem.create(item: item4, invoice: invoice8, quantity: 1, unit_price: item4.unit_price)
      item_invoice9 = InvoiceItem.create(item: item4, invoice: invoice9, quantity: 2, unit_price: item4.unit_price)
      item_invoice10 = InvoiceItem.create(item: item4, invoice: invoice10, quantity: 2, unit_price: item4.unit_price)

      transaction1 = Transaction.create(invoice: invoice1, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
      transaction2 = Transaction.create(invoice: invoice2, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
      transaction3 = Transaction.create(invoice: invoice3, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
      transaction4 = Transaction.create(invoice: invoice4, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
      transaction5 = Transaction.create(invoice: invoice5, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
      transaction6 = Transaction.create(invoice: invoice6, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
      transaction7 = Transaction.create(invoice: invoice7, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
      transaction8 = Transaction.create(invoice: invoice8, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
      transaction9 = Transaction.create(invoice: invoice9, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
      transaction10 = Transaction.create(invoice: invoice10, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")

      quantity = 2

      expect(Merchant.most_items_sold(quantity)).to eq([merchant4, merchant3])
      expect(Merchant.most_items_sold(quantity)).to_not include(merchant1, merchant2)
    end
  end
end
