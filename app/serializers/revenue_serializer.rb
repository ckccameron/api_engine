class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :revenue
  # def self.revenue(revenue)
  #   {
  #     "data": {
  #       "id": nil,
  #       "attributes": {
  #         "revenue": revenue
  #       }
  #     }
  #   }
  # end
end
