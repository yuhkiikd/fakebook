class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy, :confirm]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all.order(id: "DESC")
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = current_user.feeds.build(feed_params)
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /feeds/1/edit
  def edit
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    if params[:back]
      redirect_to feeds_path
    elsif params[:delete_image]
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

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:image, :image_cache, :content)
    end
end