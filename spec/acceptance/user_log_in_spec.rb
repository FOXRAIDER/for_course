require 'rails_helper'

feature 'show questions' do
    given(:user) { create(:user) }

    scenario 'log in' do
        visit root_path
        click_on 'Login'

        expect(page).to have_content  'Log in'
    end

    scenario 'sign in?' do
        sign_in(user)
    
        expect(page).to have_content 'Signed in successfully.'
        expect(current_path).to eq root_path
    end
    scenario 'invalid login ' do
        visit new_user_session_path
        fill_in 'Email', with: 'user@test.com'
        fill_in 'Password', with: '12345678'
        click_on 'Log in'
        expect(page).to have_content 'Invalid Email or password.'
    end
    scenario 'Sing up' do
        visit new_user_session_path
        click_on 'Sign up'
        fill_in 'Email', with: 'qwe@test.com'
        fill_in 'Password', with: '12345678'
        fill_in 'Password confirmation', with: '12345678'
        click_on 'Sign up'
        expect(page).to have_content 'Welcome! You have signed up successfully.'
    end


    scenario 'Logout'   do
        sign_in(user)
        
        visit root_path
        click_on 'Logout'
        expect(page).to have_content  'Signed out successfully.'
    end

end