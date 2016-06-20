class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.top_rate.limit(25)
  end

  def show
    @user = User.find(params[:id])
    @user_bookmarks = @user.bookmarks
    @liked_bookmakrs = @user.likes
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information update"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
