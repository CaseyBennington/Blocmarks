require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      # user = FactoryGirl.create(:user)
      let(:user) { create(:user) }

      login_as(user, scope: :user)
      get :index
      expect(response).to have_http_status(:success)
      logout
    end
  end

end
