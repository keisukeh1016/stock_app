module ApplicationHelper
  def title
    @title ? "#{@title} | Stock" : "Stock"
  end
  
  def date_in_tokyo(date)
    t = date.in_time_zone("Tokyo")
    t.hour > 15 ? "#{t.month}/#{t.day} 15:00" : "#{t.month}/#{t.day - 1} 15:00"
  end

  def change_abs(stock)
    sprintf("%.2f", stock.dod_change.round(2).abs)
  end
end
