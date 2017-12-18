class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters
	layout 'empty'

	def create
    params[:user][:role] = User::ROLES[:admin]
    User.transaction do
      super do |resource|
        if resource.valid?
          account = Account.create(user_id: resource.id)
          resource.account_id = account.id
          resource.save
        end
      end
    end
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role])
  end
end 