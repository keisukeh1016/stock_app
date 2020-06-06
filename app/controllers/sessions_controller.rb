class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      if user.activated
        session[:user_id] = user.id
        redirect_to user_url(user), notice: "ログインしました"
      else
        redirect_to root_url, alert: "アカウントが有効化されていません"
      end
    else
      flash.now[:alert] = "ログインに失敗しました"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "ログアウトしました"
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
