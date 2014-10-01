require 'rails_helper'
require_relative '../helpers/application_helper'

describe 'restaurant reviews' do
	context 'restaurant profile page' do
		before do 
			@restaurant = Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant', rating: 5)
			visit '/'
			click_link('Register')
			fill_in('Email', with: "ethel@123.com")
			fill_in('Password', with: "password123")
			fill_in('Password confirmation', with: "password123")
			click_button('Sign up')
			leave_review('horrible stuff, will never eat there again',1)
			leave_review('great stuff, will eat there again',1)
		end
		it 'has its own profile page' do 
			visit "/restaurants/#{@restaurant.id}"
			expect(page).to have_content('Spitzweg')
			expect(page).to have_content('This is an awesome restaurant')
		end

		it 'has all its reviews printed on its page' do 
			visit "/restaurants/#{@restaurant.id}"
			expect(page).to have_content("great")
			expect(page).to have_content("horrible")
		end

		it 'has all its reviews printed on its page' do 
			visit "/restaurants/#{@restaurant.id}"
			expect(page).to have_link('Leave Review')
		end

		it 'has fields for writing the review and rating the restaurant on a scale' do
			visit "/restaurants/#{@restaurant.id}"
			click_link('Leave Review')
			expect(page).to have_field('review[content]')
			expect(page).to have_field('review[rating]')
			expect(page).to have_button('Post Review')
		end

		it 'saves new review to the database' do
			visit "/restaurants/#{@restaurant.id}"
			click_link('Leave Review')
			fill_in('review[content]', with: 'Awesome Restaurant')
			fill_in('review[rating]', with: 5)
			click_button("Post Review")
			expect(@restaurant.reviews.last.content).to eq('Awesome Restaurant')
		end

	end

	context 'invalid review' do
		before do 
			@restaurant = Restaurant.create(name: 'KFC', description: 'This is an awesome restaurant')
			visit '/'
			click_link('Register')
			fill_in('Email', with: "ethel@123.com")
			fill_in('Password', with: "password123")
			fill_in('Password confirmation', with: "password123")
			click_button('Sign up')
		end

		it 'displays an error if rating is not provided' do
			visit "/restaurants/#{@restaurant.id}"
			click_link('Leave Review')
			fill_in('review[content]', with: 'Awesome Restaurant')
			click_button("Post Review")
			expect(page).to have_content('Rating can\'t be blank')
		end
	end

	context 'user details of the author of the review' do

		before do
			@restaurant = Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant')
			visit '/'
			click_link('Register')
			fill_in('Email', with: "ethel@123.com")
			fill_in('Password', with: "password123")
			fill_in('Password confirmation', with: "password123")
			click_button('Sign up')
		end

		it 'displays the email of the user next to the review' do 
			visit "/restaurants/#{@restaurant.id}"
			leave_review('horrible stuff, will never eat there again',1)
			within(:css, '.review:first-of-type') do
				expect(page).to have_content 'ethel@123.com'
			end
		end
	end
end