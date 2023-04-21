class SessionsController < ApplicationController
    before_action :require_logged_in, only: [:destroy]
    before_action :require_logged_out, only: [:create, :new]

    def new
        @user = User.new

        render :new
    end

    def create
        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by_credentials(username, password)

        if @user
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            @user = User.new(username: username)
            render :new
        end
    end

    def destroy
        if logged_in?
            logout!
        end
        flash[:messages] = ["Successfully logged out"]
        redirect_to neW_session_url
    end
end