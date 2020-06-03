module ApplicationHelper  
  # https://www.jpx.co.jp/corporate/about-jpx/calendar/index.html
  JPX_HOLIDAY = { 1  => [1, 2, 3, 13], 2 => [11, 23, 24], 3 => [20],     4 => [29],
                  5  => [3, 4, 5, 6],  6 => [],           7 => [23, 24], 8 => [10],
                  9  => [21, 22],     10 => [],          11 => [3, 23], 12 => [31] }

  def page_title
    @page_title ? "#{@page_title} | 株式" : "株式"
  end
  
  def absolute_value(dod_change)
    sprintf("%.2f", dod_change.round(2).abs)
  end
  
  def jpx_holiday?
    t = Time.zone.now.in_time_zone("Tokyo")
    t.on_weekend? || JPX_HOLIDAY[t.month].include?(t.day)
  end

  def format_time(time)
    t = time.in_time_zone("Tokyo").to_a
    month   = t[4].to_s.length == 2 ? t[4].to_s : "0#{t[4]}"
    day     = t[3].to_s.length == 2 ? t[3].to_s : "0#{t[3]}"
    hour    = t[2].to_s.length == 2 ? t[2].to_s : "0#{t[2]}"
    minutes = t[1].to_s.length == 2 ? t[1].to_s : "0#{t[1]}"
    "#{month}/#{day} #{hour}:#{minutes}"
  end

  def header_date
    t = Time.zone.now.in_time_zone("Tokyo")
    if jpx_holiday?
      "今日は休みです"
    else
      t.hour > 15 ? "#{t.month}/#{t.day} 15:00" : "#{t.month}/#{t.day - 1} 15:00"
    end
  end

end
