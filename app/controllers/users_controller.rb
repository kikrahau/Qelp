class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		User.create(params[:user].permit(:username, :password_digest))
		redirect_to restaurants_path
	end
end
