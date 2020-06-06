class UserMailer < ApplicationMailer
  default from: 'keisuke.example@gmail.com'

  def activation(user)
    @user = user
    mail(to: @user.email, subject: 'アカウントを有効にしてください')
  end
end