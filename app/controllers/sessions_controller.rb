class SessionsController < ApplicationController
    def new
    end
    def create
        user = User.find_by(email: params[:session][:email])
        if user&.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Thanks for signing in, #{user.name}!"
            redirect_to :controller => :home, :action => :index
        else
            flash[:danger] = "Invalid email or password!"
            redirect_to new_session_path
        end
    end
    def destroy
        session[:user_id] = nil
        redirect_to :controller => :home, :action => :index
    end
end
