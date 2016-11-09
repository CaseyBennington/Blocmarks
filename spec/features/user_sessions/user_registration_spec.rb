
require 'rails_helper'

describe 'User registration' do
  context 'successful sign up' do
    before do
      visit root_path
      user_sign_up
    end

    let(:user) { build(:user) }

    it 'flash message for confirmation link' do
      expect(page).to have_content 'A message with a confirmation link has been sent'
    end
  end

  context 'unsuccessful sign up' do
    before do
      visit root_path
      click_on('sign_up', match: :first)
    end

    it 'requires valid email' do
      fill_in 'Email', with: 'john'
      fill_in 'Password', with: 'helloworld'
      fill_in 'Password confirmation', with: 'helloworld'
      click_on 'sign_up_user'
      expect(page).to have_content 'Email is invalid'
    end

    it 'requires valid password' do
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'world'
      fill_in 'Password confirmation', with: 'world'
      click_on 'sign_up_user'
      expect(page).to have_content 'Password is too short'
    end

    it 'requires matching passwords' do
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'hellowor'
      fill_in 'Password confirmation', with: 'helloworld'
      click_on 'sign_up_user'
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end
end

def user_sign_up
  click_on('sign_up', match: :first)
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  fill_in 'Password confirmation', with: user.password
  click_on 'sign_up_user'
end
