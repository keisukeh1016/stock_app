class UsersController < ApplicationController
  before_action :login_required, only: :destroy
  before_action :current_user?, only: :destroy

  def index
    @users = User.preload(:stocks, :wallet)
                 .select("users.*, sum(today_price * holding) + avg(distinct cash) as user_total_assets")
                 .joins(:stocks, :wallet)
                 .group("users.id")
                 .order(user_total_assets: :desc, id: :asc)
                 .page(params[:page])
                 .per(10)

    @page_num = params[:page] ? params[:page].to_i : 1
  end

  def show
    @user = User.preload(:stocks, :wallet)
                .find(params[:id])

    if @user.portfolios.count > 0
      @user_rank = User.joins(:stocks, :wallet)
                       .group("users.id")
                       .order( Arel.sql("sum(today_price * holding) + avg(distinct cash) desc"), id: :asc)
                       .ids
                       .index(@user.id) + 1
    else
      @user_rank = "null "
    end
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
      @user.destroy!
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
