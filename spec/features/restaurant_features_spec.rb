require 'rails_helper'
require_relative '../helpers/application_helper'
# >>> Debugging = save_and_open_page

describe 'restaurant' do

	context 'without any restaurants created' do 
		it 'can prompt that there are no restaurants' do
			visit '/restaurants' 
			expect(page).to have_content('No restaurants')
			expect(page).to have_link('Create restaurant')
		end
	end
	
	context 'restaurants have been added' do 
		before do 
			Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant')
		end

		it 'shows one restaurant' do 
			visit '/restaurants'
			expect(page). to have_content('Spitzweg')
			expect(page).not_to have_content('No restaurants')
		end

		it 'has name which is a link' do 
			visit '/restaurants'
      		expect(page).to have_link('Spitzweg')
		end
	end

	context 'add restaurants' do

		before do
			user1 = create(:user1)
			login_as(user1, :scope => :user)
		end

		it 'has a form' do 
			visit '/restaurants/new'
			expect(page).to have_css('form')
		end

		it 'can upload images for the restaurant' do 
			visit '/restaurants/new'
			fill_in('restaurant[name]', with: 'McDonalds')
			fill_in('restaurant[description]', with: 'Shit restaurant')
  			attach_file "restaurant[image]", 'spec/fixtures/images/hd_logo.gif'
			click_button('Create Restaurant')
			expect(page).to have_selector("img")
		end

		it 'when form is filled in, it shows the restaurant' do
			visit '/restaurants/new'
			fill_in('restaurant[name]', with: 'McDonalds')
			fill_in('restaurant[description]', with: 'Shit restaurant')
			click_button('Create')
			expect(page).to have_content('McDonalds')
			expect(page).not_to have_content('No restaurants')
		end

		it 'can show errors' do 
			visit '/restaurants/new'
			fill_in('restaurant[name]', with: 'Mc')
			fill_in('restaurant[description]', with: 'Shit restaurant')
			click_button('Create')
			expect(page).to have_content('Name is too short')
		end
	end

	context 'editing restaurants' do
		before do
			Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant')
			user1 = create(:user1)	
		  	login_as(user1, :scope => :user)
		end
		it 'can be edited' do
			visit "/restaurants"
			click_button('Edit')
		 	fill_in('restaurant[name]', with: 'McDonalds')
			fill_in('restaurant[description]', with: 'Shit restaurant')
			click_button('Update Restaurant')
			expect(page).to have_content('McDonalds')
		end
	end

	context 'deleting restaurants' do
		before do
			Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant')
			user1 = create(:user1)	
		  	login_as(user1, :scope => :user)
		end
		it 'can be deleted' do
			visit "/restaurants"
			click_button('Delete')
			expect(page).not_to have_content('Spitzweg')
		end
	end

	context 'profile page' do
		before do
		@restaurant = Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant',location: 'Neuss', price: 7, cuisine: 'French')
		end

		it 'has its own profile page' do 
			visit "/restaurants/#{@restaurant.id}"
			expect(page).to have_content('Spitzweg')
			expect(page).to have_content('This is an awesome restaurant')
			expect(page).to have_content('Neuss')
			expect(page).to have_content('30£ per person')
			expect(page).to have_content('French')
		end

	end
end

describe 'restaurant ratings' do
	context 'display average rating' do 
		before do 
			@restaurant = Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant')
			user1 = create(:user1)	
	  		login_as(user1, :scope => :user)
		end

		it 'displays an average rating in form of stars' do 
			leave_review('wow', 4)
			visit '/restaurants'
			expect(page).to have_content '★★★★☆'
		end
	end
end

describe 'restaurant price' do
	before do 
		@restaurant = Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant', price: 15)
	end

	it 'displays the price category of the restaurant in form of pounds' do 
		visit "/restaurants/#{@restaurant.id}"
		expect(page).to have_content '££'
	end
end