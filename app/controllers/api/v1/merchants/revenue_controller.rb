class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    quantity = params[:quantity]
    render json: MerchantSerializer.new(Merchant.most_revenue(quantity))
  end

  def show
    id = params[:merchant_id]
    value = Merchant.revenue(id)
    render json: RevenueSerializer.new(Revenue.new(value))
  end
end
