require 'rails_helper'

describe Customer, type: :model do
  it "exists with attributes" do
    attrs = {
              first_name: "Loyal",
              last_name: "Considine",
              created_at: "2012-03-27 14:54:11 UTC",
              updated_at: "2012-03-27 14:54:11 UTC"
            }
    customer = Customer.new(attrs)

    expect(customer).to be_a Customer
    expect(customer.first_name).to eq("Loyal")
    expect(customer.last_name).to eq("Considine")
    expect(customer.created_at).to eq("2012-03-27 14:54:11 UTC")
    expect(customer.updated_at).to eq("2012-03-27 14:54:11 UTC")
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  # describe "relationships" do
  #   it { should have_many(:invoices) }
  #   it { should have_many(:merchants).through(:invoices) }
  #   it { should have_many(:transactions).through(:invoices) }
  # end
end
