class UsersController < ApplicationController
	before_action :authenticate_user!
  load_and_authorize_resource

  
	def show
		@user = User.find(params[:id])
	end
end
