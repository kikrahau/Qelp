class RestaurantsController < ApplicationController

	def index
		@users = User.all
		@user = User.first
		@restaurants = Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.create(restaurant_params)
		redirect_to restaurants_path
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def edit
	end

	private
		def restaurant_params
			params.require(:restaurant).permit(:name, :description, :rating)
		end
end
