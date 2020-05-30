class ApplicationController < ActionController::Base
  before_action :top_stock

  def top_stock
    @top_stock = Stock.order(:dod_change).last
  end
end
