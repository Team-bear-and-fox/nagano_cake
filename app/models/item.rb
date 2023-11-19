class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  has_one_attached :image

  def add_tax_price
    (value * 1.08).round
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_square.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end