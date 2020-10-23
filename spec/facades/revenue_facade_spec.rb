require 'rails_helper'

describe RevenueFacade do
  it "returns total revenue across given date range" do
    customer = create(:customer)

    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)

    item1 = create(:item, merchant: merchant1, unit_price: 1.80)
    item2 = create(:item, merchant: merchant2, unit_price: 2.20)
    item3 = create(:item, merchant: merchant3, unit_price: 3.40)

    invoice1 = Invoice.create(customer: customer, merchant: merchant1, status: "shipped", created_at: 3.days.ago)
    invoice2 = Invoice.create(customer: customer, merchant: merchant2, status: "shipped", created_at: 2.days.ago)
    invoice3 = Invoice.create(customer: customer, merchant: merchant3, status: "shipped", created_at: 1.days.ago)

    item_invoice1 = InvoiceItem.create(item: item1, invoice: invoice1, quantity: 2, unit_price: 1.80)
    item_invoice2 = InvoiceItem.create(item: item2, invoice: invoice2, quantity: 2, unit_price: 2.20)
    item_invoice3 = InvoiceItem.create(item: item3, invoice: invoice3, quantity: 3, unit_price: 3.40)

    transaction1 = Transaction.create(invoice: invoice1, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
    transaction2 = Transaction.create(invoice: invoice2, credit_card_number: '111111111', credit_card_expiration_date: nil, result: "success")
    transaction3 = Transaction.create(invoice: invoice3, credit_card_number: '222222222', credit_card_expiration_date: nil, result: "success")

    start_date1 = 3.days.ago
    end_date1 = Date.today
    result1 = RevenueFacade.total_revenue_across_date_range(start_date1, end_date1)

    expect(result1.class).to eq(Revenue)
    expect(result1.revenue).to eq(18.20)

    start_date2 = "2020-10-21"
    end_date2 = "2020-10-22"
    result2 = RevenueFacade.total_revenue_across_date_range(start_date2, end_date2)
    
    expect(result2.class).to eq(Revenue)
    expect(result2.revenue).to eq(14.60)
  end
end
