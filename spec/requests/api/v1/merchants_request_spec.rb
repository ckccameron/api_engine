require 'rails_helper'

describe "Merchant requests" do
  it "sends index of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data].count).to eq(3)
    expect(body[:data].first).to have_key(:id)
    expect(body[:data].first).to have_key(:type)
    expect(body[:data].first).to have_key(:attributes)
    expect(body[:data].first[:attributes]).to have_key(:id)
    expect(body[:data].first[:attributes][:id]).to be_an(Integer)
    expect(body[:data].first[:attributes]).to have_key(:name)
    expect(body[:data].first[:attributes][:name]).to be_a(String)
  end

  it "sends merchant based on unique id" do
    merchant = create(:merchant)
    id = merchant.id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data]).to have_key(:id)
    expect(body[:data]).to have_key(:type)
    expect(body[:data]).to have_key(:attributes)
    expect(body[:data][:id]).to eq(id.to_s)
    expect(body[:data][:type]).to eq("merchant")
    expect(body[:data][:attributes][:id]).to eq(id)
    expect(body[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "allows a new merchant to be created" do
    post "/api/v1/merchants", params: {name: "Royal Palace of Gold"}

    expect(response).to be_successful

    merchant = Merchant.last

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data]).to have_key(:id)
    expect(body[:data]).to have_key(:type)
    expect(body[:data]).to have_key(:attributes)
    expect(body[:data][:attributes][:id]).to eq(merchant.id)
    expect(body[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "allows a merchant to be updated" do
    merchant = create(:merchant)
    id = merchant.id
    old_name = Merchant.last.name

    patch "/api/v1/merchants/#{id}", params: {name: "It's A New Day"}

    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)

    expect(body[:data]).to have_key(:id)
    expect(body[:data]).to have_key(:type)
    expect(body[:data]).to have_key(:attributes)
    expect(body[:data][:attributes][:id]).to eq(merchant.id)
    expect(body[:data][:attributes][:name]).to eq("It's A New Day")
    expect(body[:data][:attributes][:name]).to_not eq(old_name)
  end

  it "allows a merchant to be destroyed" do
    id1 = create(:merchant).id
    id2 = create(:merchant).id

    expect(Merchant.count).to eq(2)

    delete "/api/v1/merchants/#{id1}"

    expect(response.status).to eq(204)

    expect(Merchant.count).to eq(1)
    expect{ Item.find(id1) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
