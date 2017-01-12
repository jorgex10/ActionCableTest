module ApplicationHelper

  def day_month_year_hours_minutes date
    date.nil? ? "-" : date.strftime("%d-%b-%Y, %I:%M %p")
  end

  def format_date_to_show_message date
    from_today = Date.today.beginning_of_day < date and Date.today.end_of_day > date
    from_today ? date.strftime("%I:%M %p") : date.strftime("%b %d, %Y")
  end

end
