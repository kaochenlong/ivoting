class Candidate < ApplicationRecord
  has_many :vote_logs
  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 40 }
end
