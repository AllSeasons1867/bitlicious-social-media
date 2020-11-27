class PictureCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture_comment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  # GET /picture_comments
  # GET /picture_comments.json
  def index
    @picture_comments = PictureComment.all
  end

  # GET /picture_comments/1
  # GET /picture_comments/1.json
  def show
  end

  # GET /picture_comments/new
  def new
    @picture_comment = PictureComment.new
  end

  # GET /picture_comments/1/edit
  def edit
  end

  # POST /picture_comments
  # POST /picture_comments.json
  def create

    @picture = Picture.find params[:picture_id]
    @new_picture_comment = PictureComment.new(picture_comment_params)
    @new_picture_comment.picture = @picture
    @new_picture_comment.user = current_user
      if @new_picture_comment.save 
        redirect_to picture_path(@picture)
      else 
        @picture_comments = @picture.picture_comments.order(created_at: :desc)
        render "pictures/show"
      end


    # @picture_comment = PictureComment.new(picture_comment_params)

    # respond_to do |format|
    #   if @picture_comment.save
    #     format.html { redirect_to @picture_comment, notice: 'Picture comment was successfully created.' }
    #     format.json { render :show, status: :created, location: @picture_comment }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @picture_comment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /picture_comments/1
  # PATCH/PUT /picture_comments/1.json
  def update
    respond_to do |format|
      if @picture_comment.update(picture_comment_params)
        format.html { redirect_to @picture_comment, notice: 'Picture comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture_comment }
      else
        format.html { render :edit }
        format.json { render json: @picture_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /picture_comments/1
  # DELETE /picture_comments/1.json
  def destroy
    @picture_comment.destroy
    redirect_to picture_path(@picture_comment.picture)
    # respond_to do |format|
    #   format.html { redirect_to picture_comments_url, notice: 'Picture comment was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture_comment
      @picture_comment = PictureComment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_comment_params
      params.require(:picture_comment).permit(:body, :picture_id)
    end
    def authorize_user!
      unless can?(:manage, @picture_comment)
        flash[:danger] = "Access Denied"
        redirect_to :controller => :home, :action => :index
      end
    end
end
