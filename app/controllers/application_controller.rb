class ApplicationController < ActionController::Base
  helper_method :current_user

  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
      redirect_to root_url unless current_user
    end

    def stock_day_change
      '(today_price - yesterday_price) / yesterday_price * 100'
    end
end
