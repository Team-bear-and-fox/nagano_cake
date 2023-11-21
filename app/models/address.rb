class Address < ApplicationRecord
  belongs_to :customer
  
  def address_display
    "〒" + postal_code + "　" + address + "　" + last_name + "　" + first_name
  end
  
end
