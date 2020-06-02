class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(session_params)

    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private
    def session_params
      params.require(:session).permit(:name)
    end
end
