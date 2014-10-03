require 'rails_helper'

RSpec.describe Restaurant, type: :model do 
	it 'is not valid with a name of less than 3 characters' do 
		restaurant = Restaurant.new(name: "Et")
		expect(restaurant).to have(1).error_on(:name)
	end

	it 'is not valid when it already exists' do 
		Restaurant.create(name: "Ethel's café")
		restaurant = Restaurant.new(name: "Ethel's café")
		expect(restaurant).to have(1).error_on(:name)
	end

	describe 'average rating' do 
		context 'no reviews' do 
			it 'returns No Reviews' do 
				restaurant = Restaurant.create(name: "Ethel's Steak House")
				expect(restaurant.average_rating).to eq('No reviews yet')
			end
		end
		context 'only one review' do 
			it 'returns the rating of one review' do 
				restaurant = Restaurant.create(name: "Ethel's Steak House")
				restaurant.reviews.create(rating: 4)
				expect(restaurant.average_rating).to eq 4
			end
		end
		context 'several reviews' do 
			it 'returns the average of all ratings' do 
				restaurant = Restaurant.create(name: "Ethel's Steak House")
				restaurant.reviews.create(rating: 4, user_id: 1)
				restaurant.reviews.create(rating: 2, user_id: 2)
				expect(restaurant.average_rating).to eq 3
			end
		end
	end

	describe 'price category' do
		it 'returns no price category given' do
			restaurant = Restaurant.create(name: "Ethel's Steak House")
			expect(restaurant.price_category).to eq 'No price category given'
		end

		it 'is in the price category "£", when having an average price per meal of 1-10£' do
			restaurant = Restaurant.create(name: "Ethel's Steak House", price: 10)
			expect(restaurant.price_category).to eq 1
		end

		it 'is in the price category "££", when having an average price per meal of 11-20£' do
			restaurant = Restaurant.create(name: "Ethel's Steak House", price: 20)
			expect(restaurant.price_category).to eq 2
		end

		it 'is in the price category "£££", when having an average price per meal of 21-31£' do
			restaurant = Restaurant.create(name: "Ethel's Steak House", price: 31)
			expect(restaurant.price_category).to eq 3
		end

		it 'is in the price category "££££", when having an average price per meal of 32-100£' do
			restaurant = Restaurant.create(name: "Ethel's Steak House", price: 32)
			expect(restaurant.price_category).to eq 4
		end
	end
end