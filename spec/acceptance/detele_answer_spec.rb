require 'rails_helper'

feature 'watch and delete answer' do

    given(:user) { create(:user) }


    scenario 'watch and create answer' do
        sign_in(user)

        visit questions_path
        click_on 'Ask question'
        fill_in 'Title', with: 'qqq'
        fill_in 'Body', with: 'qwe'
        click_on 'Create'
        expect(page).to have_content("Your question successfully created.")
        
        click_on 'home'
        
        click_on 'show'
        expect(page).to have_text('qqq')
        expect(page).to have_text('qwe')
        
        click_on 'Reply'
        expect(page).to have_button('Create Answer')
        fill_in 'Body', with: 'qqwe'
        click_on 'Create Answer'
        click_on 'delete'
        expect(page).to have_text('qqq','qwe')        
    end
end