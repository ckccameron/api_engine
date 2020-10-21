require 'rails_helper'

describe "Merchant relationship to Item request" do
  it "returns list of items associated with a merchant" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    id1 = merchant1.id
    id2 = merchant2.id

    item1 = create(:item, merchant_id: id1)
    item2 = create(:item, merchant_id: id1)
    item3 = create(:item, merchant_id: id1)
    item4 = create(:item, merchant_id: id2)
    item5 = create(:item, merchant_id: id2)

    get "/api/v1/merchants/#{id1}/items"

    expect(response).to be_successful

    id1_items = JSON.parse(response.body, symbolize_names: true)

    expect(id1_items[:data].count).to eq(3)
    expect(id1_items[:data].first).to have_key(:id)
    expect(id1_items[:data].first).to have_key(:type)
    expect(id1_items[:data].first).to have_key(:attributes)
    expect(id1_items[:data].first[:attributes]).to have_key(:id)
    expect(id1_items[:data].first[:attributes][:id]).to be_an(Integer)
    expect(id1_items[:data].first[:attributes][:id]).to_not eq(nil)
    expect(id1_items[:data].first[:attributes]).to have_key(:name)
    expect(id1_items[:data].first[:attributes][:name]).to be_a(String)
    expect(id1_items[:data].first[:attributes][:name]).to_not eq(nil)
    expect(id1_items[:data].first[:attributes]).to have_key(:description)
    expect(id1_items[:data].first[:attributes][:description]).to be_a(String)
    expect(id1_items[:data].first[:attributes][:description]).to_not eq(nil)
    expect(id1_items[:data].first[:attributes]).to have_key(:unit_price)
    expect(id1_items[:data].first[:attributes][:unit_price]).to be_a(Float)
    expect(id1_items[:data].first[:attributes][:unit_price]).to_not eq(nil)
    expect(id1_items[:data].first[:attributes]).to have_key(:merchant_id)
    expect(id1_items[:data].first[:attributes][:merchant_id]).to be_an(Integer)
    expect(id1_items[:data].first[:attributes][:merchant_id]).to_not eq(nil)
  end
end
