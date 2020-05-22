class StocksController < ApplicationController
  def index
    @stocks = Stock.order(:code)
  end

  def show
    @stock = Stock.find_by(code: params[:id])
    @price = Price.find_by(code: params[:id])
  end
end
