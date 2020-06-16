class StocksController < ApplicationController
  def index
    @q = Stock.ransack(params[:q])
    @stocks = @q.result.order(stock_day_change + ' desc').limit(20)
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private
    def search_params
      params.require(:q).permit(:code_eq, :name_cont)
    end
end