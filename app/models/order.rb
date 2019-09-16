class Order < ApplicationRecord
  extend FriendlyId
  friendly_id :order_generator, use: :slugged

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

  private
  def order_generator
    year = Time.now.year
    month = Time.now.month
    day = Time.now.day
    serial = [*'A'..'Z', *0..9].sample(8).join

    "%0d%02d%02d-%s" % [year, month, day, serial]
  end
end
