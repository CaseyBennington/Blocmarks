require 'rails_helper'

RSpec.describe IncomingController, type: :controller do
  describe 'Post#create with Mailgun params' do

    let(:receive_email) do
      post :create, 'body-plain' => 'http://google.com/new_rails_gem', subject: 'New Rails Gem', sender: 'member@example.com'
    end

    let(:email_from_registered_user) do
      post :create, 'body-plain' => 'https://google.com/rails5', subject: 'Rails 5 Released!', sender: 'member@example.com'
    end

    let(:email_with_existing_topic) do
      post :create, 'body-plain' => 'https://rubygems.org', subject: 'Rails 5 Released!', sender: 'member@example.com'
    end

    context "when no user exists" do
      it "creates a new User" do
        expect { receive_email }.to change(User, :count).by 1
      end

      it "creates a new Topic" do
        expect { receive_email }.to change(Topic, :count).by 1
      end

      it "creates a new Bookmark" do
        expect { receive_email }.to change(Bookmark, :count).by 1
      end
    end

    context "when user exists" do
      before do
        receive_email
      end

      it "does not create new User" do
        expect { email_from_registered_user }.to change(User, :count).by 0
      end
    end

    context "when topic exists" do
      before do
        email_from_registered_user
      end

      it "does not create new Topic" do
        expect { email_with_existing_topic }.to change(Topic, :count).by 0
      end
    end
  end
end
