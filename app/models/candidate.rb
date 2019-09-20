class Candidate < ApplicationRecord
  paginates_per 10
  has_many :vote_logs
  has_many :users, through: :vote_logs
  has_one :signature
  accepts_nested_attributes_for :signature

  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 40 }

  default_scope { where(deleted_at: nil) }

  def destroy
    update(deleted_at: Time.now)
  end
end
