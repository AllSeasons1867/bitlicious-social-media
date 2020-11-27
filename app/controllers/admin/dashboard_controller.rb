class Admin::DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    def index
        @users = User.all
    end
    def destroy
        @user = User.find(params[:id])
    unless @user.admin?
        @user.replies.destroy_all
        @user.video_comments.destroy_all
        @user.comments.destroy_all
        @user.picture_comments.destroy_all
        @user.story_comments.destroy_all
        @user.pictures.destroy_all
        @user.posts.destroy_all
        @user.stories.destroy_all
        @user.videos.destroy_all
        @user.destroy
    end
        redirect_to admin_dashboard_index_path
    end
private
    def authorize_admin!
        unless current_user.admin?
            flash[:danger] = "Access Denied"
            redirect_to root_path
        end
    end
end
