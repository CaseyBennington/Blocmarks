require 'rails_helper'

describe 'Liking bookmarks', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic) }

  before do
    login_as(user, scope: :user)
    visit new_topic_bookmark_path(topic)
    create_bookmark
    visit topics_path(topic)
  end

  context 'when user is present' do
    it 'displays link to favorite bookmark' do
      expect(page).to have_link 'favorite_bookmark'
    end
  end

  context 'when no user is present' do
    before do
      sign_out_user
      visit topic_path(topic)
    end

    it 'hides link to favorite bookmark' do
      expect(page).not_to have_link 'favorite_bookmark'
    end
  end

  context 'when not favorited' do
    it 'displays link to favorite bookmark' do
      expect(page).to have_link 'favorite_bookmark'
    end
  end

  context 'when favorited' do
    before do
      click_link('favorite_bookmark', match: :first)
    end

    it 'displays link to remove favorite' do
      expect(page).to have_link 'remove_favorite'
    end
  end
end

def create_bookmark
  fill_in 'url', with: bookmark.url
  click_on 'create_bookmark'
end

def sign_out_user
  click_link 'sign_out'
end
