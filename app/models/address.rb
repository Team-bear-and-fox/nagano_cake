class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  
  def address_display
    "〒" + postal_code + "　" + address + "　" + last_name + "　" + first_name
  end
  
end
