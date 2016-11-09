require 'rails_helper'

describe 'User Favorites', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }

  before do
    login_as(user, scope: :user)
    visit user_path(user)
  end

  context 'when user has topics' do
    before do
      visit topics_path
      10.times do
        create_topic
      end
      visit user_path(user)
    end

    it 'displays topic#count' do
      expect(page).to have_content user.likes.count
    end
  end

  context 'when removing topics' do
    before do
      create_topic
      visit user_path(user)
      click_on 'topics_link'
    end

    it 'displays link to delete topic' do
      expect(page).to have_link 'delete_topic'
    end

    it 'removes user topic' do
      click_on('delete_topic', match: :first)
      visit user_path(user)
      click_on 'topics_link'
      click_on('delete_topic', match: :first)
      visit user_path(user)
      expect(page).not_to have_content topic.title
    end

    it 'redirects to user-profile' do
      click_on('delete_topic', match: :first)
      visit user_path(user)
      expect(current_path).to eq user_path(user)
    end
  end
end

def create_topic
  visit new_topic_path
  fill_in 'title', with: topic.title
  click_on 'create_topic'
end
