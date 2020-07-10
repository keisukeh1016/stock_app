class PortfoliosController < ApplicationController
  before_action :login_required

  def create
    @portfolio = current_user.portfolios.build(portfolio_params)
    return unless portfolio_valid?

    @portfolio.save!
    redirect_to user_url(current_user), notice: "銘柄を購入しました"
  end

  def update
    set_portfolio
    return unless portfolio_valid?

    @portfolio.update!(portfolio_params)
  end

  def destroy
    set_portfolio
    return unless portfolio_valid?
    
    @portfolio.destroy!
  end

  private
    def portfolio_params
      params.require(:portfolio).permit(:stock_code, :holding)
    end

    def set_portfolio
      @portfolio = current_user.portfolios.find(params[:id])
      @portfolio.holding = portfolio_params[:holding]  
    end

    def portfolio_valid?
      redirect_to user_url(current_user), alert: "現金が不足しています" and return unless @portfolio.user_has_enough_money?
      redirect_to user_url(current_user), alert: "銘柄登録の上限は５件です" and return if @portfolio.excess_count_limit?
      true
    end
end
