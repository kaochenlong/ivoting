class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user
  validates :recipient, :phone, :address, presence: true
end
