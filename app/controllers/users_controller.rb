class UsersController < ApplicationController

  # GET /users/boennemann
  # GET /users/boennemann.json
  def show
    @user = User.find_by username: params[:username]

    unless @user
      redirect_to :root, flash: { error: "This user does not exist." }
    end
  end

  # Gladly adapted from http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin/
  # and further modified.
  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    @user = User.find(params[:id])

    if request.patch? && params[:user] && params[:user][:email]
      if @user.update(params.require(:user).permit([:email]))
        @user.skip_reconfirmation!
        sign_in @user, :bypass => true
        redirect_to :root, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end
end
