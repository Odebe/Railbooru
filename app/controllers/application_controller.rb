class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :authenticate_user!

  rescue_from ActionController::RoutingError do |exception|
	 logger.error 'Routing error occurred'
	 render plain: '404 Not found', status: 404 
	end
	def catch_404
		raise ActionController::RoutingError.new(params[:path])
	end

	protected

	def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  
end
