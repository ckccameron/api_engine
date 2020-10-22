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

  it "can return single item when given created at or updated at query" do
    merchant = create(:merchant)
    item = create(:item, name: "Boomshakalaka", merchant_id: merchant.id, created_at: "21 Oct 2020 12:00:00 UTC +00:00", updated_at: "21 Oct 2020 12:00:00 UTC +00:00")

    attribute1 = "created_at"
    query1 = "21"

    get "/api/v1/items/find?#{attribute1}=#{query1}"

    expect(response).to be_successful

    item_result = JSON.parse(response.body, symbolize_names: true)

    expect(item_result[:data]).to be_a(Hash)
    expect(item_result[:data]).to have_key(:id)
    expect(item_result[:data]).to have_key(:type)
    # binding.pry
    # expect(item_result[:data][:type]).to eq("item")
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

    attribute2 = "updated_at"
    query2 = "Oct"

    get "/api/v1/items/find?#{attribute2}=#{query2}"

    expect(response).to be_successful

    item_result = JSON.parse(response.body, symbolize_names: true)

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
  end

  it "can return index of merchants that match search criteria" do
    create(:merchant, name: "Basketball Blvd")
    create(:merchant, name: "Basketball Bonanza")
    create(:merchant, name: "Full Court Press")
    create(:merchant, name: "Goooaaalll")

    attribute = "name"
    query = "ball"

    get "/api/v1/merchants/find_all?#{attribute}=#{query}"

    expect(response).to be_successful

    merchants_results = JSON.parse(response.body, symbolize_names: true)
    names = merchants_results[:data].map do |merchant|
      merchant[:attributes][:name].downcase
    end
    expect(merchants_results[:data].count).to eq(2)
    expect(merchants_results[:data]).to be_an(Array)
    merchants_results[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:type)
      expect(merchant).to have_key(:attributes)
      expect(merchant[:type]).to eq("merchant")
      expect(merchant[:attributes]).to have_key(:id)
      expect(merchant[:attributes][:id]).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
    names.each do |name|
      expect(name).to include(query)
    end
end
