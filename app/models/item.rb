class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  belongs_to :merchant
  
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  scope :date_search, -> (param) {where("to_char(#{param.keys.first},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{param.values.first}%")}
  scope :attribute_search, -> (param) {where("items.#{param.keys.first}::text ILIKE ?", "%#{param.values.first}%")}

  def self.find_single_item(param)
    attribute = param.keys.first
    if attribute == 'created_at' || attribute == 'updated_at'
      date_search(param).first
    else
      attribute_search(param).first
    end
  end

  def self.find_all_items(param)
    attribute = param.keys.first
    if attribute == 'created_at' || attribute == 'updated_at'
      date_search(param)
    else
      attribute_search(param)
    end
  end
end
