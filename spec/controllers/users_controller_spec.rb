require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    @user.confirmed_at = Time.now
    @user.save
  end

  describe 'GET #show' do
    it 'returns http success' do
      sign_in
      get :show, id: @user.id
      expect(response).to have_http_status(:success)
    end
  end
end
