class PortfoliosController < ApplicationController
  def create
    portfolio = current_user.portfolios.create(portfolio_params)
    update_average(current_user)
    redirect_to user_url(current_user), notice: "銘柄を追加しました"
  end

  def destroy
    portfolio = current_user.portfolios.find_by(portfolio_params).destroy
    update_average(current_user)
    redirect_to user_url(current_user), notice: "銘柄を削除しました"
  end

  private
    def portfolio_params
      params.require(:portfolio).permit(:stock_code)
    end

    def update_average(user)
      arr = user.stocks.pluck(:dod_change)
      average = arr.empty? ? 0 : arr.sum / arr.length
      user.update(portfolio_average: average) 
    end
end
