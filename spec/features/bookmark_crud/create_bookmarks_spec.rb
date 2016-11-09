require 'rails_helper'

describe 'Creation of bookmarks', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  before do
    login_as(user, scope: :user)
    visit new_topic_bookmark_path(topic)
    visit topic_path(topic)
  end

  context 'when user is present' do
    it 'displays form to create url' do
      expect(page).to have_link 'create_bookmark'
    end
  end

  context 'when user who created record is present' do
    before do
      visit new_topic_bookmark_path(topic)
      fill_in 'url', with: bookmark.url
      click_on 'create_bookmark'
      visit user_path(user)
    end

    it "adds created bookmark to user's profile" do
      expect(page).to have_content bookmark.url
    end
  end

  context 'when no user is present' do
    # Sign out user then navigate back to topic#show
    before do
      sign_out_user
      visit topic_path(topic)
    end

    it 'hides form to create bookmarks' do
      expect(page).not_to have_link 'create_bookmark'
    end
  end

  context 'valid bookmark' do
    before do
      visit new_topic_bookmark_path(topic)
      fill_in 'url', with: bookmark.url
      click_on 'create_bookmark'
    end

    it 'displays newly created bookmark' do
      expect(page).to have_content bookmark.url
    end
  end

  context 'invalid bookmark' do
    context 'when url is invalid' do
      it 'displays error when url is blank' do
        visit new_topic_bookmark_path(topic)
        click_on 'create_bookmark'
        expect(page).to have_content 'There was an error saving the bookmark. Please try again.'
      end
    end
  end
end

def sign_out_user
  click_link 'sign_out'
  visit topic_path(topic)
end
