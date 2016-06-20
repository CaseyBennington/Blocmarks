class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    # @topics = policy_scope(Topic)
    @topics = Topic.all
  end

  def show
    # authorize @topic
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def create
    @topic = current_user.topics.new(topic_params)
    authorize @topic

    if @topic.save
      flash[:notice] = 'Topic was saved successfully.'
      redirect_to @topic
    else
      flash.now[:alert] = 'Error creating topic. Please try again.'
      render :new
    end
  end

  def update
    # @wiki.assign_attributes(wiki_params)
    authorize @wiki

    if @topic.update(topic_params)
      # @topic.slug = nil
      @topic.save!
      flash[:notice] = 'Topic was updated successfully.'
      redirect_to @topic
    else
      flash.now[:alert] = 'Error saving topic. Please try again.'
      render :edit
    end
  end

  def destroy
    authorize @topic

    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = 'There was an error deleting the topic.'
      render :show
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :user_id)
  end
end
