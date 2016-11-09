require 'rails_helper'

describe 'User links' do
  context 'when no user exists' do
    before do
      visit root_path
    end

    it 'displays sign up link' do
      expect(page).to have_link 'sign_up'
    end

    it 'displays sign in link' do
      expect(page).to have_link 'sign_in'
    end
  end

  context 'when user exists' do
    let(:user) { build(:user) }

    before do
      login_as(user, scope: :user)
      visit root_path
    end

    it "displays user's email as label" do
      expect(page).to have_content user.email
    end

    it "displays link to user's profile" do
      expect(page).to have_link 'profile'
    end

    it 'displays link to edit user' do
      expect(page).to have_link 'edit_user'
    end

    it 'displays link to sign out' do
      expect(page).to have_link 'sign_out'
    end
  end
end
