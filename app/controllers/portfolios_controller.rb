class PortfoliosController < ApplicationController
  before_action :login_required

  def create
    portfolio = current_user.portfolios.build(portfolio_params)

    if portfolio.save
      update_average(current_user)
      redirect_to user_url(current_user), notice: "銘柄を追加しました"
    else
      redirect_to user_url(current_user), alert: "銘柄登録の上限は５件です"
    end
  end

  def destroy
    current_user.portfolios.find_by(portfolio_params).destroy
    update_average(current_user)
    redirect_to user_url(current_user), alert: "銘柄を削除しました"
  end

  private
    def portfolio_params
      params.require(:portfolio).permit(:stock_code)
    end

    def update_average(user)
      arr = user.stocks.pluck(:dod_change)
      average = arr.empty? ? 0 : arr.sum / arr.length
      user.update_attribute(:portfolio_average, average) 
    end
end
