class UsersController < ApplicationController
  before_action :login_required, only: :destroy
  before_action :current_user?, only: :destroy

  def index
    @users = User.select("users.*, avg(#{stock_day_change}) as user_day_change")
                 .joins(:stocks)
                 .group("users.id")
                 .order("user_day_change desc")
                 .limit(10)

    @users_portfolios = User.select("users.id as user_id, stocks.code as stock_code, stocks.name as stock_name, 
                                     #{stock_day_change} as stock_day_change")
                            .joins(:stocks)
                            .order("stock_day_change desc")
  end

  def show
    @user = User.find(params[:id])

    @user_rank = User.joins(:stocks)
                     .group("users.id")
                     .having("avg(#{stock_day_change}) > #{@user.day_change}")
                     .length + 1

    @stocks = @user.stocks.order(stock_day_change + ' desc')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.activation(@user).deliver_now
      redirect_to root_url, notice: "メールを送信しました"
    else
      flash.now[:alert] = "新規登録に失敗しました"
      render "new"
    end
  end

  def destroy
    if @user.email == "test@example.com"
      redirect_to @user, alert: "テストユーザーは削除できません"
    else
      @user.destroy
      redirect_to root_url, alert: "アカウントを削除しました"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
    
    def current_user?
      @user = User.find(params[:id])
      redirect_to root_url unless @user == current_user
    end
end
