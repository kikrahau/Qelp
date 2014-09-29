require 'rails_helper'

# >>> Debugging = save_and_open_page


describe 'restaurant' do 
	context 'without any restaurants created' do 
		it 'can prompt that there are no restaurants' do
			visit '/restaurants' 
			expect(page).to have_content('No restaurants')
			expect(page).to have_link('Create restaurant')
		end
	end
end