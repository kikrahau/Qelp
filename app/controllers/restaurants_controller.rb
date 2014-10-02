class RestaurantsController < ApplicationController

	def index
		@restaurants = Restaurant.all
	end

	def new
		if user_signed_in?
			@restaurant = Restaurant.new
		else
			flash[:notice] = "Please log in or sign up for an account."
			redirect_to new_user_session_path
		end
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		if @restaurant.save
			redirect_to restaurants_path
		else
			render 'new'
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def edit
		if user_signed_in?
			@restaurant = Restaurant.find(params[:id])
		else
			flash[:notice] = "Please log in or sign up for an account."
			redirect_to new_user_session_path
		end
	end

	def destroy
		if user_signed_in?
			@restaurant = Restaurant.find(params[:id])
			@restaurant.destroy
			redirect_to restaurants_path

		else
			flash[:notice] = "Please log in or sign up for an account."
			redirect_to new_user_session_path
		end
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		@restaurant.update(restaurant_params)
		redirect_to restaurants_path
	end

	private
		def restaurant_params
			params.require(:restaurant).permit(:name, :description, :rating, :image)
		end
end
