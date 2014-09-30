require 'rails_helper'

describe 'user ' do 
	context 'user signs up' do 
		it 'has a sign up form' do 
			visit '/users/new'
			fill_in('Username', with: 'Ethel123supergirl')
			fill_in('Password', with: 'password')
			fill_in('Password confirmation', with: 'password')
			click_button('Sign Up')
			expect(page).to have_content('Welcome Ethel123supergirl!')
		end
	end
end