require 'rails_helper'

describe "business intelligence requests" do
  it "returns total revenue across date range for all merchants" do
    customer1 = create(:customer)
    customer2 = create(:customer)

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)

    invoice1 = Invoice.create(customer: customer1, merchant: merchant1, status: "shipped", created_at: 4.days.ago)
    invoice2 = Invoice.create(customer: customer1, merchant: merchant2, status: "shipped", created_at: 4.days.ago)
    invoice3 = Invoice.create(customer: customer1, merchant: merchant3, status: "shipped", created_at: 3.days.ago)
    invoice4 = Invoice.create(customer: customer2, merchant: merchant1, status: "shipped", created_at: 2.days.ago)
    invoice5 = Invoice.create(customer: customer2, merchant: merchant2, status: "shipped", created_at: 2.days.ago)
    invoice6 = Invoice.create(customer: customer2, merchant: merchant3, status: "shipped", created_at: 1.days.ago)

    item_invoice1 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 1, unit_price: item1.unit_price)
    item_invoice2 = InvoiceItem.create(item: item2, invoice: invoice2, quantity: 1, unit_price: item2.unit_price)
    item_invoice3 = InvoiceItem.create(item: item3, invoice: invoice3, quantity: 1, unit_price: item3.unit_price)
    item_invoice4 = InvoiceItem.create(item: item1, invoice: invoice4, quantity: 1, unit_price: item1.unit_price)
    item_invoice5 = InvoiceItem.create(item: item2, invoice: invoice5, quantity: 1, unit_price: item2.unit_price)
    item_invoice6 = InvoiceItem.create(item: item3, invoice: invoice6, quantity: 1, unit_price: item3.unit_price)

    transaction1 = Transaction.create(invoice: invoice1, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
    transaction2 = Transaction.create(invoice: invoice2, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
    transaction3 = Transaction.create(invoice: invoice3, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
    transaction4 = Transaction.create(invoice: invoice4, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
    transaction5 = Transaction.create(invoice: invoice5, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
    transaction6 = Transaction.create(invoice: invoice6, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")

    start_date = 3.days.ago
    end_date = Date.today
    get "/api/v1/revenue?start=#{start_date}&end=#{end_date}"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a(Hash)
    expect(result[:data]).to have_key(:id)
    expect(result[:data][:id]).to eq(nil)
    expect(result[:data]).to have_key(:attributes)
    expect(result[:data][:attributes]).to have_key(:revenue)
    expect(result[:data][:attributes][:revenue]).to be_a(Float)
  end
end
