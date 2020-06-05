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
  
  def jpx_holiday?(time)
    time.on_weekend? || JPX_HOLIDAY[time.month].include?(time.day)
  end

  def header_date
    t = Time.zone.now.getlocal("+09:00")
    if jpx_holiday?(t)
      t = t-1.day while jpx_holiday?(t)
      t.strftime("%m/%d 15:00")
    else
      # return (t-1.day).strftime("%m/%d 15:00") if t.hour < 12
      # return t.strftime("%m/%d 11:30") if t.hour < 16
      # return t.strftime("%m/%d 15:00")
      t.hour > 15 ? t.strftime("%m/%d 15:00") : (t-1.day).strftime("%m/%d 15:00")
    end
  end

end