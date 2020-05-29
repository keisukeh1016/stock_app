class ApplicationController < ActionController::Base
  before_action :first_stock

  def first_stock
    @first_stock = Stock.first 
  end
end
