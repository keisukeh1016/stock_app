class UsersController < ApplicationController
  before_action :last_updated_stock

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
