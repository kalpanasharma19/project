class Product < ApplicationRecord
  default_scope { order(id: :asc) }

  has_many :order_items
  has_many :shopping_cart_items
  has_attached_file :image, styles: { thumb: ["64x64#", :jpg], original: ['500x500>', :jpg] },
                            convert_options: { thumb: "-quality 75 -strip", original: "-quality 85 -strip" }

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :stock_quantity, presence: true

  validates_attachment :image, presence: true, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                               size: { in: 0..500.kilobytes }
end
