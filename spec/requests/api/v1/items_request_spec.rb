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

  it "sends item based on unique id" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    id = item.id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)
    
    expect(body[:data]).to have_key(:id)
    expect(body[:data]).to have_key(:type)
    expect(body[:data]).to have_key(:attributes)
    expect(body[:data][:id]).to eq(id.to_s)
    expect(body[:data][:type]).to eq("item")
    expect(body[:data][:attributes][:id]).to eq(id)
    expect(body[:data][:attributes][:name]).to eq(item.name)
    expect(body[:data][:attributes][:description]).to eq(item.description)
    expect(body[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(body[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end
end
