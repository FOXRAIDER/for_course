require 'rails_helper'

feature 'Create and delete question', %q{sadasd} do
    given(:user) { create(:user)}

    scenario 'Auth user create question' do
        
        sign_in(user)

        visit questions_path
        click_on 'Ask question'
        fill_in 'Title', with: 'potato'
        fill_in 'Body', with: 'green'
        click_on 'Create'
        expect(page).to have_text('potato', 'green')
        click_on 'home'
        expect(page).to have_text('potato', 'green')
        click_on 'delete'
        expect(page).to have_no_text('potato', 'green')
        expect(page).to have_no_button('show')

    end
    scenario 'Dont auth user' do
        visit root_path

        expect(page).to have_no_button('Ask question')        

    end

end