class Order < ApplicationRecord
  has_many :order_items
  validates :recipient, :phone, :address, presence: true
end
