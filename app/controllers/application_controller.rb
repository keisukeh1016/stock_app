class ApplicationController < ActionController::Base
  def last_updated_stock
    @last_updated_stock = Stock.order(:updated_at).first
  end
end
