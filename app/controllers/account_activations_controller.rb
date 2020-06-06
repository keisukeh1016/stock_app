class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated && BCrypt::Password.new(user.activation_digest) == params[:id]
      user.update_attribute(:activated, true)
      session[:user_id] = user.id
      redirect_to user, notice: "アカウントが有効化されました"
    else
      redirect_to root_url, alert: "無効なリンクです"
    end
  end 

end
