require 'rails_helper'

describe "Updating bookmarks", js: true do
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
    it "displays link to update bookmark" do
      expect(page).to have_link "edit_bookmark"
    end
  end

  context "with incorrect permissions" do
    before do
      sign_out_user
      visit topic_path(topic)
    end

    it "hides link to update bookmark" do
      expect(page).not_to have_link "edit_bookmark"
    end
  end

  context "when link is clicked" do
    before do
      click_on('edit_bookmark', match: :first)
    end

    it "displays form to update bookmark" do
      expect(page).to have_button "edit_bookmark"
    end
  end

  context "valid update" do
    before do
      click_on('edit_bookmark', match: :first)
      within(".edit_bookmark") do
        fill_in "url", with: "www.google.com"
        click_on "edit_bookmark"
      end
    end

    it "updates bookmark" do
      expect(page).to have_content "New Topic"
    end
  end

  context "invalid update" do
    before do
      click_on('edit_bookmark', match: :first)
    end

    context "when url is invalid" do
      it "displays error when url is blank" do
        within(".edit_bookmark") do
          # Url is currently filled in - must be replaced with blank string
          fill_in "url", with: ""
          click_on "edit_bookmark"
        end
        expect(page).to have_content "There was an error saving the bookmark. Please try again."
      end

      it "displays error when url is invalid" do
        within(".edit_bookmark") do
          fill_in "url", with: "http://wwwwgoogleccom"
          click_on "edit_bookmark"
        end
        expect(page).to have_content "There was an error saving the bookmark. Please try again."
      end
    end
  end
end

def create_bookmark
  fill_in 'url', with: bookmark.url
  click_on 'create_bookmark'
end

def sign_out_user
  click_link "sign_out"
  visit topic_path(topic)
end
