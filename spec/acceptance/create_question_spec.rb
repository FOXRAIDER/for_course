require 'rails_helper'

feature 'Create question', %q{sadasd} do
    given(:user) { create(:user)}

    scenario 'Auth user create question' do
        
        sign_in(user)

        visit questions_path
        click_on 'Ask question'
        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'text text'
        click_on 'Create'
        expect(page).to have_content("Your question successfully created.")
    end
    scenario 'Dont auth user' do
        visit questions_path
        click_on 'Ask question'

        expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

end