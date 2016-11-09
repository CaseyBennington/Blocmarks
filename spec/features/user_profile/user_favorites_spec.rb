require 'rails_helper'

describe 'User Favorites', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic) }
  let!(:like) { create(:like, bookmark: bookmark, user: user) }

  before do
    login_as(user, scope: :user)
    visit user_path(user)
  end

  context 'when user has favorites' do
    before do
      visit topic_path(topic)
      10.times do
        create_bookmark_and_like
      end
      visit user_path(user)
    end

    it 'displays like#count' do
      expect(page).to have_content user.likes.count
    end
  end

  context 'when removing favorites' do
    before do
      click_on 'likes_link'
      click_link 'remove_favorite'
    end

    it 'removes user favorite' do
      expect(page).not_to have_content bookmark.url
    end

    it 'redirects to user-profile' do
      expect(current_path).to eq user_path(user)
    end
  end
end

def create_bookmark_and_like
  visit new_topic_bookmark_path(topic)
  fill_in 'url', with: bookmark.url
  click_on 'create_bookmark'
  click_on 'favorite_bookmark'
end
