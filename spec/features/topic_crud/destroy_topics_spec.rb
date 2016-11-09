require 'rails_helper'

describe 'Destroying topics', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:topic) { create(:topic, user: user) }

  before do
    create_and_nav_to_topic
  end

  context 'with correct permissions' do
    # Navigate to topics#show of current_user's created topic
    it 'displays link to destroy topic' do
      expect(page).to have_link 'delete_topic'
    end

    it 'deletes topic' do
      click_on 'delete_topic'
      visit topic_path(topic)
      expect(page).not_to have_content topic.title
    end
  end

  context 'when viewing other users topic' do
    # Sign out User and view topics#show of other users created topic
    before do
      sign_out_user
      login_as(user2, scope: :user)
    end

    it 'does not display link to destroy topic' do
      expect(page).not_to have_link 'delete_topic'
    end
  end

  context 'with no user present' do
    # Sign out User and view topics#show with no current_user
    before do
      sign_out_user
    end

    it 'does not display link to destroy topic' do
      expect(page).not_to have_link 'delete_topic'
    end
  end
end

def create_and_nav_to_topic
  login_as(user, scope: :user)
  visit new_topic_path
  fill_in 'title', with: topic.title
  click_on 'create_topic'
  visit topic_path(topic)
end

def sign_out_user
  click_link 'sign_out'
end
