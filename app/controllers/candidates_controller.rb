class CandidatesController < ApplicationController
  def index
    @candidates = Candidate.all
  end

  def show
    @candidate = Candidate.find_by(id: params[:id])
  end

  def new
    @candidate = Candidate.new
  end

  def create
    # 寫入資料庫
    # Strong Parameters
    clean_params = params.require(:candidate).permit(:name, :age, :policy, :party)
    @candidate = Candidate.new(clean_params)

    if @candidate.save
      flash[:notice] = "新增候選人成功!"
      redirect_to root_path
    else
      # redirect_to new_candidate_path
      render :new
    end
  end
end
