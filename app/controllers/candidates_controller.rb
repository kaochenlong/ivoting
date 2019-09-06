class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote, :log]

  def index
    @candidates = Candidate.order(vote: :desc).page(params[:page])
  end

  def show
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to root_path, notice: "新增候選人成功!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to root_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    redirect_to root_path, notice: "資料刪除成功!"
  end

  def vote
    if user_signed_in?

      log = current_user.vote_logs.new(candidate: @candidate,
                                       ip_address: request.remote_ip)

      if log.save
        message = "投票成功"
      else
        message = log.errors.full_messages.first
      end

      redirect_to root_path, notice: message
    else
      redirect_to root_path, notice: '請先登入會員!'
    end
  end

  def log
    @logs = @candidate.vote_logs.includes(:user)
  end

  private
  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end

  # Strong Parameters
  def candidate_params
    params.require(:candidate).permit(:name, :age, :policy, :party, :degree)
  end
end
