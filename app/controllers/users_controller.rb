class UsersController < ApplicationController
  before_action :login_required, only: :destroy
  before_action :current_user?, only: :destroy

  def index
    @users = User.select("users.*,
                          sum(today_price * holding) + cash as user_total_assets,
                          avg(#{stock_day_change}) as user_day_change")
                 .joins(:stocks)
                 .group("users.id")
                 .order("user_total_assets desc")
                 .limit(10)

    @users_portfolios = User.select("portfolios.*,
                                     users.*,
                                     stocks.*,
                                     #{stock_day_change} as stock_day_change,
                                     today_price * holding as user_subtotal_asset")
                            .joins(:stocks)
                            .order("user_subtotal_asset desc")
  end

  def show
    @user = User.find(params[:id])
    
    @user_rank = User.joins(:stocks)
                     .group("users.id")
                     .having("sum(today_price * holding) + cash > #{@user.total_assets}")
                     .length + 1

    @stocks = Stock.select("stocks.*,
                            portfolios.*,
                            #{stock_day_change} as stock_day_change,
                            today_price * holding as user_subtotal_asset")
                   .joins(:users)
                   .where("users.id = #{@user.id}")
                   .order("user_subtotal_asset desc")
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
