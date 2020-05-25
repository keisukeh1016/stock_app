module ApplicationHelper
  def title
    title = "Stock"
    title = "#{@title} | #{title}" if @title
    title
  end

  def price(stock)
    return if stock.price.nil?

    if (stock.price.ceil - stock.price) == 0
      stock.price.ceil
    else
      stock.price
    end
  end

  def date(stock)
    t = stock.updated_at.in_time_zone("Tokyo")
    
    if t.hour > 15
      "#{t.month}/#{t.day} 15:00"
    else
      "#{t.month}/#{t.day - 1} 15:00"
    end
  end

end
