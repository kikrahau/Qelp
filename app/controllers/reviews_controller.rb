class ReviewsController < ApplicationController
	def new
		if user_signed_in?
			@restaurant = Restaurant.find(params[:restaurant_id])
			@review = Review.new
			if !@restaurant.reviews.find_by(user_id: current_user.id).nil?
				flash[:notice] = "Can't review a restaurant more than once."
				redirect_to restaurant_path(@restaurant) 
			end
		else
			flash[:notice] = "Please log in or sign up for an account."
			redirect_to new_user_session_path
		end
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
 		@review = @restaurant.reviews.new(params[:review].permit(:content, :rating))
	    @review.user_id = current_user.id
	    if @review.save
	    	redirect_to restaurant_path(@restaurant)
	    else
	    	render 'new'
	    end
	end
end
