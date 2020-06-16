class PortfoliosController < ApplicationController
  before_action :login_required

  def create
    portfolio = current_user.portfolios.build(portfolio_params)

    if portfolio.save
      redirect_to user_url(current_user), notice: "銘柄を追加しました"
    else
      redirect_to user_url(current_user), alert: "銘柄登録の上限は５件です"
    end
  end

  def destroy
    current_user.portfolios.find_by(portfolio_params).destroy
    redirect_to user_url(current_user), alert: "銘柄を削除しました"
  end

  private
    def portfolio_params
      params.require(:portfolio).permit(:stock_code)
    end
end
