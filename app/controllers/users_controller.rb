class UsersController < ApplicationController

    before_action :set_user!, only: %i[edit update]

    def new
        @user = User.new
    end

    def edit

    end

    def update
        if @user.update user_params
            flash[:success] = "Ваш профиль обновлен!"
            redirect_to edit_user_path(@user)
          else
            render :edit
          end       
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Добро пожаловать!"
            redirect_to root_path
        else
            render :new
        end 
    end

    private

    def set_user!
        @user = User.find params[:id]
      end
    

    def user_params
        params.require(:user).permit(:email, :name, :password, :password_confirm)
    end 
end
