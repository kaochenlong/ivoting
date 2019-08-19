class CandidatesController < ApplicationController
  def index
  end

  def new
    @candidate = Candidate.new
  end

  def create
    # 寫入資料庫
    @candidate = Candidate.new(params["candidate"])
    if @candidate.save
      render html: 'ok'
    else
      render html: 'fail'
    end
  end
end
