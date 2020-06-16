class StocksController < ApplicationController
  def index
    @q = Stock.ransack(params[:q])

    if current_user
      @stocks = @q.result
                  .includes(:users)
                  .order(stock_day_change + ' desc')
                  .limit(20)
    else
      @stocks = @q.result
                  .order(stock_day_change + ' desc')
                  .limit(20)
    end
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private
    def search_params
      params.require(:q).permit(:code_eq, :name_cont)
    end
end