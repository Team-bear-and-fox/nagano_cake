class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  has_one_attached :image
  
  def add_tax_value
    (self.value * 1.10).round
  end
  
end
