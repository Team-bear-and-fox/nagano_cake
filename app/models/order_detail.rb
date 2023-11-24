class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
　enum production_status: { production_unable: 0, production_pending: 1, in_production: 2, production_complete: 3 }
  
  def add_sub_total
    (item.value * 1.10).floor * amount
  end
end
