class CandidatePolicy
  attr_reader :user, :candidate

  def initialize(user, candidate)
    @user = user
    @candidate = candidate
  end

  def new?
    user.role == 'admin' or user.role == 'teacher'
  end

  def edit?
    user.role == 'admin' or user.role == 'teacher'
  end

  def update?
    user.role == 'admin' or user.role == 'teacher'
  end

  def destroy?
    user.role == 'admin' or user.role == 'teacher'
  end
end