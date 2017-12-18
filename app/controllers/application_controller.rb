class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_locale

  protected

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"  
    if current_user.is_admin?
	    redirect_to root_path 
    else
      redirect_to insurance_types_path 
    end
  end

  def set_locale
  	if params[:locale]
	    I18n.locale = params[:locale] || I18n.default_locale
	    session[:locale] = I18n.locale
	  end
  end

  def set_current_user
    User.current = current_user
  end

  def current_account
    current_user.account if current_user.present?
  end
end
