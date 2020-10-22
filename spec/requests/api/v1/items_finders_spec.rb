require 'rails_helper'

describe "Items finder requests" do
  it "can return single item when given query params" do
    merchant = create(:merchant)
    item = create(:item, name: "Boomshakalaka", merchant_id: merchant.id)

    attribute = "name"
    query = "sHaKa"

    get "/api/v1/items/find?#{attribute}=#{query}"

    expect(response).to be_successful

    item_result = JSON.parse(response.body, symbolize_names: true)
    name = item_result[:data][:attributes][:name].downcase

    expect(item_result[:data]).to be_a(Hash)
    expect(item_result[:data]).to have_key(:id)
    expect(item_result[:data]).to have_key(:type)
    expect(item_result[:data][:type]).to eq("item")
    expect(item_result[:data]).to have_key(:attributes)
    expect(item_result[:data][:attributes]).to have_key(:id)
    expect(item_result[:data][:attributes][:id]).to be_an(Integer)
    expect(item_result[:data][:attributes]).to have_key(:name)
    expect(item_result[:data][:attributes][:name]).to be_a(String)
    expect(item_result[:data][:attributes]).to have_key(:description)
    expect(item_result[:data][:attributes][:description]).to be_a(String)
    expect(item_result[:data][:attributes]).to have_key(:unit_price)
    expect(item_result[:data][:attributes][:unit_price]).to be_a(Float)
    expect(item_result[:data][:attributes]).to have_key(:merchant_id)
    expect(item_result[:data][:attributes][:merchant_id]).to be_an(Integer)
    expect(name).to include(query.downcase)
  end
end
