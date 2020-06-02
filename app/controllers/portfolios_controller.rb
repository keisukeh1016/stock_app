class PortfoliosController < ApplicationController
  def create
    current_user.portfolios.create(portfolio_params)
    redirect_to user_url(current_user)
  end

  def destroy
    current_user.portfolios.find_by(portfolio_params).destroy
    redirect_to user_url(current_user)
  end

  private
    def portfolio_params
      params.require(:portfolio).permit(:stock_code)
    end
end
