class DeliveryAddress < ApplicationRecord
  belongs_to :customer
  has_many :orders

  validates_associated :orders

  validates :customer_id, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, length: {is: 10}, format: { with: /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed" }
end
