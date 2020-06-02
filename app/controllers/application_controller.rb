class ApplicationController < ActionController::Base
  helper_method :first_stock, :current_user

  private
    def first_stock
      @firts_stock = Stock.first
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
end
