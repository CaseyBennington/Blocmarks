require 'rails_helper'

describe "Destroying bookmarks", js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic, user: user) }

  before do
    login_as(user, scope: :user)
    visit new_topic_bookmark_path(topic)
    create_bookmark
    visit topic_path(topic)
  end

  context "with correct permissions" do
    it "displays link to destroy bookmark" do
      expect(page).to have_link "delete_bookmark"
    end

    it "allows user to destroy bookmark" do
      click_on('delete_bookmark', match: :first)
      click_on('delete_bookmark', match: :first)
      visit topic_path(topic)
      expect(page).not_to have_content bookmark.url
    end

    it "removes bookmark from user's profile" do
      click_on('delete_bookmark', match: :first)
      visit user_path(user)
      expect(page).not_to have_content bookmark.url
    end
  end

  context "with incorrect permissions" do
    before do
      sign_out_user
      visit topic_path(topic)
    end

    it "hides link to update bookmark" do
      expect(page).not_to have_link "delete_bookmark"
    end
  end
end

def create_bookmark
  fill_in 'url', with: bookmark.url
  click_on 'create_bookmark'
end
