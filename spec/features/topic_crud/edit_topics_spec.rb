require 'rails_helper'

describe 'Editing topics', js: true do
  Capybara.javascript_driver = :webkit

  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:topic) { create(:topic, user: user) }

  before do
    create_and_nav_to_topic
  end

  describe 'editing permissions' do
    context "when viewing current_user's topic" do
      # Navigate to topics#show of current_users created topic
      it 'displays link to edit topic' do
        expect(page).to have_link 'edit_topic'
      end
    end

    context "when viewing other user's topic" do
      before do
        sign_out_user
        login_as(user2, scope: :user)
      end

      # Sign out User and view topics#show of other users created topic
      it 'does not show link to edit topic' do
        expect(page).not_to have_link 'edit_topic'
      end
    end

    context 'with no user present' do
      # Sign out User and view topics#show with no current_user
      before do
        sign_out_user
      end

      it 'does not display link to edit topic' do
        expect(page).not_to have_link 'edit_topic'
      end
    end
  end

  context 'when edit link is clicked' do
    before do
      click_link 'edit_topic'
    end

    it 'displays form to edit topic' do
      expect(page).to have_button('edit_topic')
    end

    context 'with valid update' do
      it 'displays edited topic' do
        fill_in 'title', with: 'New Title'
        click_on 'edit_topic'
        expect(page).to have_content 'New Title'
      end
    end

    context 'with invalid title' do
      it 'displays error message' do
        fill_in 'title', with: 'new'
        click_on 'edit_topic'
        expect(page).to have_content 'Error saving topic. Please try again.'
      end
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
  # visit topic_path(topic)
end
