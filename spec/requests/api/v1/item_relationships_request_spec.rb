require 'rails_helper'

describe "Item relationship to Merchant request" do
  it "returns merchant associated with an item" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    item = create(:item, merchant_id: merchant3.id)
    id = item.id

    get "/api/v1/items/#{id}/merchant"

    expect(response).to be_successful

    item_merchant = JSON.parse(response.body, symbolize_names: true)
    
    expect(item_merchant.count).to eq(1)
    expect(item_merchant[:data]).to have_key(:id)
    expect(item_merchant[:data]).to have_key(:type)
    expect(item_merchant[:data][:type]).to eq("merchant")
    expect(item_merchant[:data]).to have_key(:attributes)
    expect(item_merchant[:data][:attributes]).to have_key(:id)
    expect(item_merchant[:data][:attributes][:id]).to be_an(Integer)
    expect(item_merchant[:data][:attributes][:id]).to_not eq(nil)
    expect(item_merchant[:data][:attributes]).to have_key(:name)
    expect(item_merchant[:data][:attributes][:name]).to be_a(String)
    expect(item_merchant[:data][:attributes][:name]).to_not eq(nil)
  end
end
