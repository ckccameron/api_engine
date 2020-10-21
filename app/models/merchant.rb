class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices

  scope :date_search, -> (param) { where("to_char(#{param.keys.first}, 'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{param.values.first}%") }
  scope :attribute_search, -> (param) { where("merchants.#{param.keys.first}::text ILIKE ?", "%#{param.values.first}%") }

  def self.find_single_merchant(param)
    attribute = param.keys.first
    if attribute == 'created_at' || attribute == 'updated_at'
      date_search(param).first
    else
      attribute_search(param).first
    end
  end

  def self.find_all_merchants(param)
    attribute = param.keys.first
    if attribute == 'created_at' || attribute == 'updated_at'
      date_search(param)
    else
      attribute_search(param)
    end
  end
end
