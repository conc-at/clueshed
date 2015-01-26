class VotesController < ApplicationController
  before_action :authenticate_user!

  # POST /votes.json
  def create
    vote = Vote.new vote_params

    unless own?(vote)
      vote.errors.add(:base, "You must not create votes for others.")
      return render json: vote.errors, status: :unauthorized
    end

    if vote.save
      render json: vote, status: :created
    else
      render json: vote.errors, status: :unprocessable_entity
    end
  end

  # DELETE /votes/1.json
  def destroy
    vote = Vote.find(params[:id])

    unless own?(vote)
      vote.errors.add(:base, "You must not destroy votes of others.")
      return render json: vote.errors, status: :unauthorized
    end

    vote.destroy
    head :no_content
  end

  private
    def vote_params
      params.require(:vote).permit(:user_id, :interest_id, :contrib_id)
    end

    def own?(vote)
      vote.user == current_user
    end
end
