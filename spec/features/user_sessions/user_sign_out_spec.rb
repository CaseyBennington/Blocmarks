require 'rails_helper'

describe 'User sign out' do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit root_path
    click_on 'sign_out'
  end

  it 'redirects to root_path' do
    expect(current_path).to eq root_path
  end

  it 'flashes confirmation message' do
    expect(page).to have_content 'Signed out successfully'
  end
end
