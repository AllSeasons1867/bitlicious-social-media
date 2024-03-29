class PicturesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  PICTURES_PER_PAGE = 3
  # GET /pictures
  # GET /pictures.json
  def index
    @picturesperpage = PICTURES_PER_PAGE
    if params.fetch(:page, 0).to_i < 0
      @page = 0
    else
      @page = params.fetch(:page, 0).to_i
    end
      @allpictures = Picture.all.count.to_i
      @pictures = Picture.offset(@page * PICTURES_PER_PAGE).limit(PICTURES_PER_PAGE)
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture_comments = @picture.picture_comments.order(created_at: :desc)
    @picture_comment = PictureComment.new
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user = current_user
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:title, :description, :picture)
    end
    def authorize_user!
      unless can?(:manage, @picture)
        flash[:danger] = "Access Denied"
        redirect_to picture_path(@picture)
      end
    end
end
