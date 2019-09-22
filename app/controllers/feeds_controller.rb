class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user, only: [:edit]

  def index
    @feeds = Feed.all.order(id: "DESC")
  end

  def show
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    if params[:delete_image]
      @feed.image = nil
      render :new
    else
      render :new if @feed.invalid?
    end
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    if params[:back]
      render :new
    else
      if @feed.save
        redirect_to feeds_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if params[:delete_image]
      @feed.image = nil
      @feed.save
      redirect_to edit_feed_path
    else
      if @feed.update(feed_params)
        redirect_to feeds_path, notice: "記事を編集しました！"
      else
        render :edit
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: '記事を削除しました！' }
      format.json { head :no_content }
    end
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:image, :image_cache, :content)
  end

  def ensure_current_user
    unless current_user.id == @feed.user_id
      redirect_to feeds_path
    end
  end
end