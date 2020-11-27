class StoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  STORIES_PER_PAGE = 20
  # GET /stories
  # GET /stories.json
  def index
    @storiesperpage = STORIES_PER_PAGE
    if params.fetch(:page, 0).to_i < 0
      @page = 0
    else
      @page = params.fetch(:page, 0).to_i
    end
      @allstories = Story.all.count.to_i
      @stories = Story.offset(@page * STORIES_PER_PAGE).limit(STORIES_PER_PAGE)
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @story_comment = StoryComment.new
    @story_comments = @story.story_comments.order(created_at: :desc)
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    @story.user = current_user
    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:title, :body)
    end
    def authorize_user!
      unless can?(:manage, @story)
        flash[:danger] = "Access Denied"
        redirect_to story_path(@story)
      end
    end
end
