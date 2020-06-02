class UsersController < ApplicationController
  def index
    @users = User.order(portfolio_average: :desc)
  end

  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks.order(dod_change: :desc)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)

    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      render "new"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
