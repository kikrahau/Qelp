require 'rails_helper'

describe 'user ' do 
	context 'user signs up' do
		
		before do
		  user = User.create email: 'ethel@gmail.com', password: '12345678', password_confirmation: '12345678'
		end

		it 'has a sign up form' do 
			visit '/restaurants'
			click_link('Register')
			fill_in('Email', with: 'Ethel123supergirl@gmail.com')
			fill_in('Password', with: 'password')
			fill_in('Password confirmation', with: 'password')
			click_button('Sign up')
			expect(page).to have_content('Welcome! You have signed up successfully.')
		end

		it 'has a sign in form' do 
			visit '/restaurants'
			click_link('Login')
			fill_in('Email', with: 'ethel@gmail.com')
			fill_in('Password', with: '12345678')
			click_button('Log in')
			expect(page).to have_content('Signed in successfully.')
		end
	end

	context 'restrictions for logged out users' do
		before do
			@restaurant = Restaurant.create(name: "Ethel's authentic Ramen Hut", description: 'Average ramen, not too good, had better ones in London, the one vincent recommended was far better, but keep it up Ethel!', rating: 3)
		end

		it 'can only create a restaurant when logged in' do
			visit '/restaurants'
			click_link 'Create restaurant'
			expect(page).to have_content('Please log in or sign up for an account.')
		end

		it'can only edit a restaurant when logged in' do
			visit '/restaurants'
			click_button 'Edit'
			expect(page).to have_content('Please log in or sign up for an account.')			
		end

		it 'can only review restaurants, when logged in' do
			visit "/restaurants/#{@restaurant.id}"
			click_link 'Leave Review'
			expect(page).to have_content('Please log in or sign up for an account.')			

		end

	end

	context 'user forgets password' do
		before do
		  user = User.create email: 'ethel@gmail.com', password: '12345678', password_confirmation: '12345678'
		end

		it 'can type in her/his email to receive a mail with password reset instructions' do
			visit '/restaurants'
			click_link('Login')
			click_link('Forgot your password?')
			expect(page.current_path).to eq '/users/password/new'
		end

		it 'is sent a mail with password reset instructions' do
			visit '/users/password/new'
			fill_in('Email', with: 'ethel@gmail.com')
			click_button('Send me reset password instructions')
			expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
		end
	end
end