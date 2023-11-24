class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, presence: true
  def add_sub_total
    (item.value * 1.10).floor * amount
  end
end
