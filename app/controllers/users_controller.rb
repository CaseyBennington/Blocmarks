class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_bookmarks = @user.bookmarks
    @liked_bookmarks = @user.likes
    @user_topics = @user.topics
  end
end
