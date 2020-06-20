class StocksController < ApplicationController
  def index
    @q = Stock.ransack(params[:q])

    @stocks = @q.result
                .order("(today_price - yesterday_price) / yesterday_price * 100 desc")
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private
    def search_params
      params.require(:q).permit(:code_eq, :name_cont)
    end
end