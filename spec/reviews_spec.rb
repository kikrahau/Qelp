require 'rails_helper'

# >>> Debugging = save_and_open_page

describe 'reviews' do
	before do 
		@restaurant = Restaurant.create(name: 'Shithole', description: 'Shit served hot')
	end

	it 'is possible to review a restaurant' do 
		@restaurant.reviews.create(content: "The restaurant is shit", rating: 1)
		expect(@restaurant.reviews.first.content).to eq "The restaurant is shit"
	end
end