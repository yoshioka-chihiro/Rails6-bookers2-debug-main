class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def after_sign_in_path_for(resource)
    if current_user
        flash[:notice] = "Signed in successfully."
        user_path(current_user.id)
    else
        flash[:notice] = "Welcome! You have signed up successfully."
        user_path(current_user.id)
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
