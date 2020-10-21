require 'rails_helper'

describe "Merchants finder requests" do
  it "can return single merchant when given query params" do
    create(:merchant, name: "Basketball Blvd")
    create(:merchant, name: "Basketball Bonanza")
    create(:merchant, name: "Full Court Press")

    get "/api/v1/merchants/find?name=basketball"

    expect(response).to be_successful

    merchant_result = JSON.parse(response.body, symbolize_names: true)
    name = search_body[:data][:attributes][:name].downcase

    expect(search_body[:data]).to be_a(Hash)
    expect(name).to include("in")
  end
end
