class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = Bookmark.all
  end

  def new
    @topic = Topic.friendly.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def create
    @topic = Topic.friendly.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user
    @bookmark.add_image
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = 'Bookmark was saved successfully.'
      redirect_to @topic
    else
      flash.now[:alert] = 'There was an error saving the bookmark. Please try again.'
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = 'Bookmark was updated successfully.'
      redirect_to topics_path
    else
      flash.now[:alert] = 'There was an error saving the bookmark. Please try again.'
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to @bookmark.topic
    else
      flash.now[:alert] = 'There was an error deleting the bookmark.'
      render :show
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :topic_id, :user_id, :title, :image)
  end
end
