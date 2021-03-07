class HomeController < ApplicationController    
    def index
        @videos = Video.last(3)
        @posts = Post.last(10)
        @pictures = Picture.last(3)
    end
    def show
    end
    def donation
    end
    def search 
        if params[:q].blank? 
            redirect_to(root_path, alert: "No Search Query Given!") and return
        else 
            parameter = params[:q].downcase
            @posts = Post.search(params[:q]).limit(10)
            @stories = Story.search(params[:q]).limit(10)
            @videos = Video.search(params[:q]).limit(10)
            @pictures = Picture.search(params[:q]).limit(10)
        end
    end 
    private 
end
