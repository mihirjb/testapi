class RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

respond_to :html,:json
layout "form"


  # GET /users/sign_up
  def new

    # Override Devise default behaviour and create a profile as well
    build_resource({})
    respond_with self.resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:email, :password, :password_confirmation, :username, :avatar)
    }
    
     devise_parameter_sanitizer.for(:account_update) { |u|
        u.permit(:email, :password, :password_confirmation, :username, :avatar, :current_password)
      }
  end
  
  
end
