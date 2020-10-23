class Api::V1::Merchants::ItemsSoldController < ApplicationController
  def index
    quantity = params[:quantity]
    render json: MerchantSerializer.new(Merchant.most_items_sold(quantity))
  end
end
