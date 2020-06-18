class PortfoliosController < ApplicationController
  before_action :login_required

  def create
    @portfolio = current_user.portfolios.build(portfolio_params)
    set_cash
    return unless portfolio_valid?

    ActiveRecord::Base.transaction do
      @portfolio.save!
      current_user.wallet.update!(cash: @cash)
    end

    redirect_to user_url(current_user), notice: "銘柄を購入しました"
  end

  def update
    set_portfolio
    set_cash
    return unless portfolio_valid?

    ActiveRecord::Base.transaction do
      @portfolio.update!(portfolio_params)
      current_user.wallet.update!(cash: @cash)
    end
    
    redirect_to user_url(current_user), notice: "売買が完了しました"
  end

  def destroy
    set_portfolio
    set_cash
    return unless portfolio_valid?
    
    ActiveRecord::Base.transaction do
      @portfolio.destroy!
      current_user.wallet.update!(cash: @cash)
    end
    
    redirect_to user_url(current_user), notice: "銘柄を売却しました"
  end

  private
    def portfolio_params
      params.require(:portfolio).permit(:stock_code, :holding)
    end

    def set_portfolio
      @portfolio = current_user.portfolios.find(params[:id])
      @portfolio.holding = portfolio_params[:holding]  
    end

    def set_cash
      @cash = current_user.wallet.cash - ( @portfolio.stock.today_price * (@portfolio.holding - @portfolio.already_holding) )
    end

    def portfolio_valid?
      redirect_to user_url(current_user), alert: "正の整数を入力してください" and return if @portfolio.holding < 0
      redirect_to user_url(current_user), alert: "現金が不足しています" and return if @cash < 0
      redirect_to user_url(current_user), alert: "銘柄登録の上限は５件です" and return if @portfolio.already_exist_more_than_4?
      true
    end
end
