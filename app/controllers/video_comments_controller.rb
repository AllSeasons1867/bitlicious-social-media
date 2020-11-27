class VideoCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_video_comment, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    def create
        @video = Video.find params[:video_id]
        @video_comment = VideoComment.new video_comment_params
        @video_comment.video = @video
        @video_comment.user = current_user
        if @video_comment.save
            redirect_to video_path(@video)
        else
            @video_comments = @video.video_comments.order(created_at: :desc)
            render "videos/show"
        end
    end
    def show

        @video = @video_comment.video
    end
    def edit

    end
    def update

        respond_to do |format|
            if @video_comment.update(video_comment_params)
              format.html { redirect_to @video_comment, notice: 'Comment was successfully updated.' }
              format.json { render :show, status: :ok, location: @video_comment }
            else
              format.html { render :edit }
              format.json { render json: @video_comment.errors, status: :unprocessable_entity }
            end
          end
    end
    def destroy

        @video_comment.destroy
        redirect_to video_path(@video_comment.video)
    end
    private
    def set_video_comment
        @video_comment = VideoComment.find(params[:id])
    end
    def video_comment_params
        params.require(:video_comment).permit(:body, :video_id)
    end
    def authorize_user!
        unless can?(:manage, @video_comment)
          flash[:danger] = "Access Denied"
          redirect_to :controller => :home, :action => :index
        end
      end
end
