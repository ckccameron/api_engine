require 'rails_helper'

describe "Merchants API" do
  it "sends index of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    body = JSON.parse(response.body)
    expect(body["data"].count).to eq(3)
    expect(body["data"].first).to have_key(:id)
    expect(body["data"].first).to have_key(:type)
    expect(body["data"].first).to have_key(:attributes)
  end
end