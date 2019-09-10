class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user
  validates :recipient, :phone, :address, presence: true

  include AASM
  aasm(column: 'status', no_direct_assignment: true) do
    state :pending, initial: true
    state :paid, :delivered, :refunded, :cancelled

    event :pay do
      transitions from: :pending, to: :paid
    end

    event :cancel do
      transitions from: :pending, to: :cancelled
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end

    event :refund do
      transitions from: [:delivered, :paid], to: :refunded
    end
  end

end
