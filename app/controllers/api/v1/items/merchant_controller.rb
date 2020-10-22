class Api::V1::Items::MerchantController < ApplicationController
  def show
    item_id = params[:item_id]
    render json: MerchantSerializer.new(Item.find(item_id).merchant)
  end
end
