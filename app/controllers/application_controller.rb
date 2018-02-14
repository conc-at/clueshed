class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :latest_partips
  before_action :expose_config

  # Gladly adapted from http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin/
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end

    def partips
      @interests = Interest.all
      @contribs = Contrib.all
    end

    def latest_partips
      @latest_interests = Interest.all.last(5).reverse
      @latest_contribs = Contrib.all.last(5).reverse
    end

    def expose_config
      @config = Rails.application.config.clueshed
    end
end
