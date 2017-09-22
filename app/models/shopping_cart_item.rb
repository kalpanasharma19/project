class ShoppingCartItem < ApplicationRecord
  default_scope { order(id: :asc) }

  belongs_to :customer
  belongs_to :product

  validates_associated :product
  validates :customer_id, presence: true
end
