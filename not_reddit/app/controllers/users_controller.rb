class UsersController < ApplicationController
    before_action :require_logged_out, only:[:create,:new]
    before_action :require_logged_in, only:[:show,:destroy,:update,:edit,:index]
    
    
    def new
        @user = user.new 
        render :new 
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            login!(@user)
            flash[:messages] = ["successfully create user!"]
            redirect_to user_url(@user)
        else 
            flash.now[:errors] = @user.errors.full_messages
            render :new 
        end

    end

    def show
        @user = User.find(params[:id])
        render :show  
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
    end

    def update
        @user = User.find(param[:id])
        @user.update(user_params)
        redirect_to user_url(@user)
    end

    def edit 
        @user = User.find(params[:id])
        render :edit
    end

    def index
        @users = User.all 
        render :index 

    end

    private
    
    def user_params
        params.require(:user).permit(:username,:password)
    end
end
