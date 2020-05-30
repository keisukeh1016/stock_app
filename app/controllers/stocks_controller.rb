class StocksController < ApplicationController
  def index
    @stocks = Stock.order(dod_change: :desc)#.limit(20)
  end

  def show
    @stock = Stock.find_by(code: params[:id])
  end
end