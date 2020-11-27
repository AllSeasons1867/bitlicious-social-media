class VideosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  VIDEOS_PER_PAGE = 3
  # GET /videos
  # GET /videos.json
  def index
    @videosperpage = VIDEOS_PER_PAGE
    if params.fetch(:page, 0).to_i < 0
      @page = 0
    else
      @page = params.fetch(:page, 0).to_i
    end
      @allvideos = Video.all.count.to_i
      @videos = Video.offset(@page * VIDEOS_PER_PAGE).limit(VIDEOS_PER_PAGE)
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video_comments = @video.video_comments.all.order(created_at: :desc)
    @video_comment = VideoComment.new
    @video.view_count += 1
    @video.save

  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.user = current_user
    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :description, :clip, :thumbnail)
    end
    def authorize_user!
      unless can?(:manage, @video)
        flash[:danger] = "Access Denied"
        redirect_to video_path(@video)
      end
    end
end
