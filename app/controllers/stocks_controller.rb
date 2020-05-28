class StocksController < ApplicationController
  before_action :last_updated_stock

  def index
    @stocks = Stock.order(dod_change: :desc)
  end

  def show
    @stock = Stock.find_by(code: params[:id])
  end
end
