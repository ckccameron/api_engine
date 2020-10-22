class Api::V1::Items::SearchController < ApplicationController
  def index

  end

  def show
    render json: ItemSerializer.new(Item.find_single_item(search_params))
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
