class ApplicationController < ActionController::Base
  helper_method :top_stock, :current_user

  private
    def top_stock
      @top_stock = Stock.order(:dod_change).last
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
end
