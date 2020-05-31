class StocksController < ApplicationController
  def index
    @stocks = Stock.order(dod_change: :desc)
  end

  def show
    @stock = Stock.find(params[:id])
  end
end