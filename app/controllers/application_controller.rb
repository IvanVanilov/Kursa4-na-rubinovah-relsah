class ApplicationController < ActionController::Base
    include Authorization
    include Pagy::Backend
    include Authentication

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def user_signed_in?
        current_user.present?
      end

    helper_method :current_user, :user_signed_in?
end
