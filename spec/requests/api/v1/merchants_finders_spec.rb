require 'rails_helper'

describe "Merchants finder requests" do
  it "can return single merchant when given query params" do
    create(:merchant, name: "Basketball Blvd")

    attribute = "name"
    query = "bAsKeTbaLl"

    get "/api/v1/merchants/find?#{attribute}=#{query}"

    expect(response).to be_successful

    merchant_result = JSON.parse(response.body, symbolize_names: true)
    name = merchant_result[:data][:attributes][:name].downcase

    expect(merchant_result[:data]).to be_a(Hash)
    expect(merchant_result[:data]).to have_key(:id)
    expect(merchant_result[:data]).to have_key(:type)
    expect(merchant_result[:data]).to have_key(:attributes)
    expect(merchant_result[:data][:type]).to eq("merchant")
    expect(merchant_result[:data][:attributes]).to have_key(:id)
    expect(merchant_result[:data][:attributes][:id]).to be_an(Integer)
    expect(merchant_result[:data][:attributes]).to have_key(:name)
    expect(merchant_result[:data][:attributes][:name]).to be_an(String)
    expect(name).to include(query.downcase)
  end

  it "can return single merchant when given created at or updated at query" do
    create(:merchant, name: "Basketball Blvd", created_at: "'Wed, 21 Oct 2020 12:00:00 UTC +00:00'", updated_at: "'Wed, 21 Oct 2020 12:00:00 UTC +00:00'")

    attribute1 = "created_at"
    query1 = "21"

    get "/api/v1/merchants/find?#{attribute1}=#{query1}"

    expect(response).to be_successful

    merchant_result = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_result[:data]).to be_a(Hash)
    expect(merchant_result[:data]).to have_key(:id)
    expect(merchant_result[:data]).to have_key(:type)
    expect(merchant_result[:data]).to have_key(:attributes)
    expect(merchant_result[:data][:type]).to eq("merchant")
    expect(merchant_result[:data][:attributes]).to have_key(:id)
    expect(merchant_result[:data][:attributes][:id]).to be_an(Integer)
    expect(merchant_result[:data][:attributes]).to have_key(:name)
    expect(merchant_result[:data][:attributes][:name]).to be_an(String)

    attribute2 = "updated_at"
    query2 = "Oct"

    get "/api/v1/merchants/find?#{attribute2}=#{query2}"

    expect(response).to be_successful

    merchant_result = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_result[:data]).to be_a(Hash)
    expect(merchant_result[:data]).to have_key(:id)
    expect(merchant_result[:data]).to have_key(:type)
    expect(merchant_result[:data]).to have_key(:attributes)
    expect(merchant_result[:data][:type]).to eq("merchant")
    expect(merchant_result[:data][:attributes]).to have_key(:id)
    expect(merchant_result[:data][:attributes][:id]).to be_an(Integer)
    expect(merchant_result[:data][:attributes]).to have_key(:name)
    expect(merchant_result[:data][:attributes][:name]).to be_an(String)
  end

  it "can return index of merchants that match search criteria" do
    create(:merchant, name: "Basketball Blvd")
    create(:merchant, name: "Basketball Bonanza")
    create(:merchant, name: "Full Court Press")
    create(:merchant, name: "Goooaaalll")

    get "/api/v1/merchants/find_all?name=ball"

    expect(response).to be_successful

    merchants_results = JSON.parse(response.body, symbolize_names: true)
    names = merchants_results[:data].map do |merchant|
      merchant[:attributes][:name].downcase
    end

    expect(merchants_results[:data].count).to eq(2)
    expect(merchants_results[:data]).to be_a(Hash)
    merchants_results[:data].each do |merchant|
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:type]).to eq("merchant")
      expect(merchant[:data][:attributes]).to have_key(:id)
      expect(merchant[:data][:attributes][:id]).to be_an(Integer)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_an(String)
    end
  end
end
