class UsersController < ApplicationController
  before_action :current_user?, only: :destroy

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
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "新規登録しました"
    else
      flash.now[:alert] = "新規登録に失敗しました"
      render "new"
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url, notice: "アカウントを削除しました"
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
    
    def current_user?
      @user = User.find(params[:id])
      redirect_to root_url unless @user == current_user
    end
end
