module ApplicationHelper
  def title
    @title ? "#{@title} | Stock" : "Stock"
  end
  
  def change_abs(dod_change)
    sprintf("%.2f", dod_change.round(2).abs)
  end

  def updated_at(stock)
    t = stock.updated_at.in_time_zone("Tokyo")
    t.hour > 15 ? "#{t.month}/#{t.day} 15:00" : "#{t.month}/#{t.day - 1} 15:00"
  end
end
