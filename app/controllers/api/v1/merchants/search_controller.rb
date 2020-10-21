class Api::V1::Merchants::SearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.find_all_merchants(search_params))
  end

  def show
    render json: MerchantSerializer.new(Merchant.find_single_merchant(search_params))
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end
end
