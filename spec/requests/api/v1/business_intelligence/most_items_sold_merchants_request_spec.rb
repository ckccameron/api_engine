require 'rails_helper'

describe "business intelligence requests" do
  it "returns merchants with most items sold" do
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

    item_invoice1 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 1, unit_price: item1.unit_price)
    item_invoice2 = InvoiceItem.create(item: item2, invoice: invoice2, quantity: 1, unit_price: item2.unit_price)
    item_invoice3 = InvoiceItem.create(item: item2, invoice: invoice3, quantity: 1, unit_price: item2.unit_price)
    item_invoice4 = InvoiceItem.create(item: item3, invoice: invoice4, quantity: 1, unit_price: item3.unit_price)
    item_invoice5 = InvoiceItem.create(item: item3, invoice: invoice5, quantity: 1, unit_price: item3.unit_price)
    item_invoice6 = InvoiceItem.create(item: item3, invoice: invoice6, quantity: 1, unit_price: item3.unit_price)
    item_invoice7 = InvoiceItem.create(item: item4, invoice: invoice7, quantity: 1, unit_price: item4.unit_price)
    item_invoice8 = InvoiceItem.create(item: item4, invoice: invoice8, quantity: 1, unit_price: item4.unit_price)
    item_invoice9 = InvoiceItem.create(item: item4, invoice: invoice9, quantity: 1, unit_price: item4.unit_price)
    item_invoice10 = InvoiceItem.create(item: item4, invoice: invoice10, quantity: 1, unit_price: item4.unit_price)

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

    get "/api/v1/merchants/most_items?quantity=3"

    expect(response).to be_successful

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results[:data]).to be_an(Array)
    expect(results[:data].first).to have_key(:id)
    expect(results[:data].first).to have_key(:type)
    expect(results[:data].first[:type]).to eq("merchant")
    expect(results[:data].first).to have_key(:attributes)
    expect(results[:data].first[:attributes]).to have_key(:id)
    expect(results[:data].first[:attributes][:id]).to be_an(Integer)
    expect(results[:data].first[:attributes]).to have_key(:name)
    expect(results[:data].first[:attributes][:name]).to be_a(String)
    expect(results[:data].count).to eq(3)
  end
end
