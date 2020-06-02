module ApplicationHelper
  def title
    @title ? "#{@title} | 株式" : "株式"
  end
  
  def change_abs(dod_change)
    sprintf("%.2f", dod_change.round(2).abs)
  end

  def updated_at(updated_at)
    t = updated_at.in_time_zone("Tokyo").to_a
    "#{t[4]}/#{t[3]} #{t[2]}:#{t[1]}"
  end

  def header_date(updated_at)
    t = updated_at.in_time_zone("Tokyo")
    t.hour > 15 ? "#{t.month}/#{t.day} 15:00" : "#{t.month}/#{t.day - 1} 15:00"
  end
end
