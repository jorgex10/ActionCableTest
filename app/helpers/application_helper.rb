module ApplicationHelper

  def day_month_year_hours_minutes date
    date.nil? ? "-" : date.strftime("%I:%M %p - %b %d, %Y")
  end

  def date_formatter_for_chat date
    beginning_of_day = Date.today.at_beginning_of_day
    end_of_day = Date.today.at_end_of_day
    if beginning_of_day < date && date < end_of_day
      date.strftime("%I:%M %p")
    else
      date.strftime("%b %d, %Y")
    end
  end

  def format_date_to_show_message date
    from_today = Date.today.beginning_of_day < date and Date.today.end_of_day > date
    from_today ? date.strftime("%I:%M %p") : date.strftime("%b %d, %Y")
  end

  def user_avatar user
    if user.photo.file?
      image_tag user.photo.url(:thumb), class: "media-object img-circle", style: "width:40px;height:40px;"
    else
      image_tag user.avatar_url, class: "media-object img-circle", style: "width:40px;height:40px;"
    end
  end

  def user_avatar_for_search user, options = {}
    if user.photo.file?
      image_tag user.photo.url(:thumb), options
    else
      image_tag user.avatar_url, options
    end
  end

end
