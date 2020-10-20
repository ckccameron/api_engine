require 'rails_helper'

describe Transaction, type: :model do
  it "exists with attributes" do
    attrs = {
      invoice_id: 2,
      credit_card_number: "4580251236515201",
      credit_card_expiration_date: nil,
      result: "success",
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:54:09 UTC"
    }

    transaction = Transaction.new(attrs)

    expect(transaction).to be_a Transaction
    expect(transaction.invoice_id).to eq(2)
    expect(transaction.credit_card_number).to eq("4580251236515201")
    expect(transaction.credit_card_expiration_date).to eq(nil)
    expect(transaction.result).to eq("success")
    expect(transaction.created_at).to eq("2012-03-27 14:54:09 UTC")
    expect(transaction.updated_at).to eq("2012-03-27 14:54:09 UTC")
  end
end
