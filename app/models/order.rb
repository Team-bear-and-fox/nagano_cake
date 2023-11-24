class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_for_payment: 0, payment_confirmation: 1, now_making: 2, preparing_for_shipment: 3, shipped: 4 }

  def add_sub_total
    (item.value * 1.10).floor * amount
  end

end
