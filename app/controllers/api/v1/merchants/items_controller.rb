class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant_id = params[:merchant_id]
    items = Item.all
    render json: ItemSerializer.new(Merchant.find(merchant_id).items)
  end
end
