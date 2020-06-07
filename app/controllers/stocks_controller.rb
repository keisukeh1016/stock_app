class StocksController < ApplicationController
  def index
    @q = Stock.ransack(params[:q])
    @stocks = @q.result(distinct: true).order(dod_change: :desc).limit(15)
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private

    def search_params
      params.require(:q).permit(:code_eq, :name_cont)
    end
end