class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters
	layout 'empty'

	def create
    params[:user][:role] = User::ROLES[:admin]
    super
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role])
  end
end 