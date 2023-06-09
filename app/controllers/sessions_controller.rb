class SessionsController < ApplicationController
    
    def new
    end

    def create
        user = User.find_by email: params[:email]
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "С возвращением!"
            redirect_to root_path
        else
            flash.now[:warning] = "Неверный пароль!"
            redirect_to new_session_path
        end
    end

    def destroy
        session.delete :user_id
        @_current_user = nil
        flash[:success] = "До свидания!"
        redirect_to root_path
    end
end