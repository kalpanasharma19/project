class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :delivery_address
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates_associated :order_items
end
