class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActionController::RoutingError do |exception|
	 logger.error 'Routing error occurred'
	 render plain: '404 Not found', status: 404 
	end
	def catch_404
		raise ActionController::RoutingError.new(params[:path])
	end
end
