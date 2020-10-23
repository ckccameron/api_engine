require 'rails_helper'

describe "business intelligence requests" do
  it "returns revenue for a single merchant" do
    customer1 = create(:customer)
    customer2 = create(:customer)

    merchant1 = create(:merchant)

    item1 = create(:item, merchant: merchant1, unit_price: 10.20)
    item2 = create(:item, merchant: merchant1, unit_price: 20.30)
    item3 = create(:item, merchant: merchant1, unit_price: 30.40)

    invoice1 = Invoice.create(customer: customer1, merchant: merchant1, status: "shipped")
    invoice2 = Invoice.create(customer: customer1, merchant: merchant1, status: "shipped")
    invoice3 = Invoice.create(customer: customer2, merchant: merchant1, status: "shipped")
    invoice4 = Invoice.create(customer: customer2, merchant: merchant1, status: "shipped")
    invoice5 = Invoice.create(customer: customer2, merchant: merchant1, status: "shipped")

    item_invoice1 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 1, unit_price: item1.unit_price)
    item_invoice2 = InvoiceItem.create(item: item2, invoice: invoice2, quantity: 1, unit_price: item2.unit_price)
    item_invoice3 = InvoiceItem.create(item: item2, invoice: invoice3, quantity: 1, unit_price: item2.unit_price)
    item_invoice4 = InvoiceItem.create(item: item3, invoice: invoice4, quantity: 1, unit_price: item3.unit_price)
    item_invoice5 = InvoiceItem.create(item: item3, invoice: invoice5, quantity: 1, unit_price: item3.unit_price)

    transaction1 = Transaction.create(invoice: invoice1, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
    transaction2 = Transaction.create(invoice: invoice2, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
    transaction3 = Transaction.create(invoice: invoice3, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
    transaction4 = Transaction.create(invoice: invoice4, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")
    transaction5 = Transaction.create(invoice: invoice5, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")

    get "/api/v1/merchants/#{merchant1.id}/revenue"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)
    
    expect(result).to be_a(Hash)
    expect(result[:data]).to have_key(:id)
    expect(result[:data][:id]).to eq(nil)
    expect(result[:data]).to have_key(:attributes)
    expect(result[:data][:attributes]).to have_key(:revenue)
    expect(result[:data][:attributes][:revenue]).to be_a(Float)
    expect(result[:data][:attributes][:revenue]).to eq(111.60)
  end
end
