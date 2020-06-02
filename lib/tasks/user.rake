namespace :user do
  desc "ポートフォリオ平均を計算"
  task average: :environment do
    User.all.each do |user|
      arr = user.stocks.pluck(:dod_change)
      average = arr.empty? ? 0 : arr.sum / arr.length
      user.update(portfolio_average: average)
    end
  end
end