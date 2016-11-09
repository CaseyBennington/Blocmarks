require 'rails_helper'

describe 'User Bookmarks', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  before do
    login_as(user, scope: :user)
    create_bookmark
    visit user_path(user)
  end

  context 'when user has bookmarks' do
    it 'displays bookmarks#count' do
      expect(page).to have_content user.bookmarks.count
    end
  end

  context 'when removing bookmarks' do
    it 'displays link to delete bookmark' do
      expect(page).to have_link 'delete_bookmark'
    end

    it 'removes user bookmark' do
      click_on('delete_bookmark', match: :first)
      visit user_path(user)
      click_on('delete_bookmark', match: :first)
      visit user_path(user)
      expect(page).not_to have_content bookmark.url
    end

    it 'redirects to user-profile' do
      click_on('delete_bookmark', match: :first)
      visit user_path(user)
      expect(current_path).to eq user_path(user)
    end
  end
end

def create_bookmark
  visit new_topic_bookmark_path(topic)
  fill_in 'url', with: bookmark.url
  click_on 'create_bookmark'
end
