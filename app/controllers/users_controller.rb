class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_bookmarks = @user.bookmarks
    @liked_bookmakrs = @user.likes
  end
end
