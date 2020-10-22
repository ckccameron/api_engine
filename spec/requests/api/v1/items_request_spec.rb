require 'rails_helper'

describe "Item requests" do
  it "sends index of items" do
    create :merchant
    merchant = Merchant.last

    create(:item, merchant_id: merchant.id)
    create(:item, merchant_id: merchant.id)
    create(:item, merchant_id: merchant.id)

    get "/api/v1/items"

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data].count).to eq(3)
    expect(body[:data].first).to have_key(:id)
    expect(body[:data].first).to have_key(:type)
    body[:data].each do |item|
      expect(item[:type]).to eq("item")
    end
    expect(body[:data].first).to have_key(:attributes)
    expect(body[:data].first[:attributes]).to have_key(:id)
    expect(body[:data].first[:attributes][:id]).to be_an(Integer)
    expect(body[:data].first[:attributes]).to have_key(:name)
    expect(body[:data].first[:attributes][:name]).to be_a(String)
    expect(body[:data].first[:attributes]).to have_key(:description)
    expect(body[:data].first[:attributes][:description]).to be_a(String)
    expect(body[:data].first[:attributes]).to have_key(:unit_price)
    expect(body[:data].first[:attributes][:unit_price]).to be_a(Float)
    expect(body[:data].first[:attributes]).to have_key(:merchant_id)
    expect(body[:data].first[:attributes][:merchant_id]).to be_an(Integer)
  end
end
