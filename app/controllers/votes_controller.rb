class VotesController < ApplicationController
  before_action :authenticate_user!

  # POST /votes.json
  def create
    @vote = Vote.new vote_params

    respond_to do |format|
      # TODO: verify if partip belongs to current user
      if @vote.save
        format.json { render json: @vote, status: :created }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
      # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :interest_id, :contrib_id)
    end
end
