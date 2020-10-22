class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find_single_item(search_params))
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
