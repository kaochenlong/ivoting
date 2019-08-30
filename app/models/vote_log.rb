class VoteLog < ApplicationRecord
  belongs_to :candidate, counter_cache: true
  belongs_to :user
end

