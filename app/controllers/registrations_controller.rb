class RegistrationsController < Devise::RegistrationsController
  protected
    def update_resource(resource, params)
      # Let the user edit themself if they have never set a password (OAuth)
      if params[:current_password].blank? && current_user.no_password
        params.delete(:current_password)
        resource.update_without_password(params)
      else
        super
      end
    end
end
