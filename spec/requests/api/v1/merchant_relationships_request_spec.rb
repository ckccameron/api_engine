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
    expect(id1_items[:data].first[:id]).to eq(first_item.id.to_s)
    expect(id1_items[:data].last[:id]).to_not eq(last_item.id.to_s)

    get "/api/v1/merchants/#{id2}/items"

    expect(response).to be_successful

    id2_items = JSON.parse(response.body, symbolize_names: true)
    expect(id2_items[:data].count).to eq(1)
    expect(id2_items[:data].first[:id]).to eq(last_item.id.to_s)
  end
end
