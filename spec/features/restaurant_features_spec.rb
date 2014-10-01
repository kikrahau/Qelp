require 'rails_helper'
require 'timecop'

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
			Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant', rating: 5)
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
		  user = create(:user)
		  login_as(user, :scope => :user)
		end

		it 'has a form' do 
			visit '/restaurants/new'
			expect(page).to have_css('form')
		end

		it 'when form is filled in, it shows the restaurant' do
			visit '/restaurants/new'
			fill_in('restaurant[name]', with: 'McDonalds')
			fill_in('restaurant[description]', with: 'Shit restaurant')
			fill_in('restaurant[rating]', with: '1')
			click_button('Create')
			expect(page).to have_content('McDonalds')
			expect(page).not_to have_content('No restaurants')
		end

		it 'can show errors' do 
			visit '/restaurants/new'
			fill_in('restaurant[name]', with: 'Mc')
			fill_in('restaurant[description]', with: 'Shit restaurant')
			fill_in('restaurant[rating]', with: '1')
			click_button('Create')
			expect(page).to have_content('Name is too short')
		end
	end

	context 'editing restaurants' do
		before do
			Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant', rating: 5)
			user = create(:user)	
		  	login_as(user, :scope => :user)
		end
		it 'can be edited' do
			visit "/restaurants"
			click_button('Edit')
		 	fill_in('restaurant[name]', with: 'McDonalds')
			fill_in('restaurant[description]', with: 'Shit restaurant')
			fill_in('restaurant[rating]', with: '1')
			click_button('Update Restaurant')
		end
	end
end

describe 'restaurant ratings' do

	def leave_review(content,rating)
		visit '/restaurants'
		click_link 'Spitzweg'
		click_link 'Leave Review'
		fill_in 'Content', with: content
		fill_in 'Rating', with: rating
		click_button 'Post Review'
	end

	context 'display average rating' do 
		before do 
			@restaurant = Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant')
			user = create(:user)	
	  		login_as(user, :scope => :user)
		end

		it 'displays an average rating in form of stars' do 
			leave_review('wow', 4)
			visit '/restaurants'
			expect(page).to have_content '★★★★☆'
		end
	end

	context 'display timestamp' do
		before do 
			@restaurant = Restaurant.create(name: 'Spitzweg', description: 'This is an awesome restaurant')
			user = create(:user)	
	  		login_as(user, :scope => :user)
		end

		it 'shows the time each review was posted' do
			Timecop.freeze(Time.new(2014))
			leave_review('wow', 4)
			Timecop.travel(1)
			visit "/restaurants/#{@restaurant.id}"
			expect(page).to have_content 'posted less than a minute ago'
		end

		it 'shows the time each review was posted' do
			Timecop.freeze(Time.new(2014))
			leave_review('wow', 4)
			Timecop.travel(1801)
			visit "/restaurants/#{@restaurant.id}"
			expect(page).to have_content 'posted 30 minutes ago'
		end

	end
end