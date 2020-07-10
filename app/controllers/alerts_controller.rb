class AlertsController < ApplicationController
  before_action :login_required

  def create
    @alert = current_user.alerts.build(alert_params)

    case @alert.comparison
    when "以上"
      if @alert.stock.today_price >= @alert.price
        redirect_to user_url(current_user), alert: "既に条件を満たしています" and return
      end
    when "以下"
      if @alert.price >= @alert.stock.today_price
        redirect_to user_url(current_user), alert: "既に条件を満たしています" and return
      end
    end

    @alert.save!
  end

  def destroy
    @alert = current_user.alerts.find(params[:id])
    @alert.destroy!
  end

  private
    def alert_params
      params.require(:alert).permit(:stock_code, :comparison, :price)
    end
end
