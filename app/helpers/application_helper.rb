module ApplicationHelper
  def day_month_year_hours_minutes date
    date.nil? ? "-" : date.strftime("%d-%b-%Y, %I:%M %p")
  end
end
