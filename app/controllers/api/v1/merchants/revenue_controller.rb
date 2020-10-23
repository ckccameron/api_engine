class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    quantity = params[:quantity]
    render json: MerchantSerializer.new(Merchant.most_revenue(quantity))
  end
end
