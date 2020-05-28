class ApplicationController < ActionController::Base
  before_action :last_updated_stock

  def last_updated_stock
    @last_updated_stock = Stock.order(:updated_at).first
  end
end
