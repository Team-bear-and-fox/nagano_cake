class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def add_sub_total
    (item.value * 1.10).floor * amount
  end
end
