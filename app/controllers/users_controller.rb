class UsersController < ApplicationController

  # GET /users/boennemann
  # GET /users/boennemann.json
  def show
    @user = User.find_by username: params[:username]

    unless @user
      redirect_to :root, flash: { error: "This user does not exist." }
    end
  end
end
