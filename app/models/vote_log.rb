class VoteLog < ApplicationRecord
  belongs_to :candidate, counter_cache: true
  belongs_to :user

  validate :validate_vote

  private
  def validate_vote
    if VoteLog.exists?(candidate: candidate, user: user)
      errors[:候選人] << "已經投過了!"
    elsif user.vote_logs.count >= 3
      errors[:投票] << "不能超過 3 筆!"
    end
  end
end

