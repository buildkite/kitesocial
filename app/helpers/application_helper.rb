module ApplicationHelper
  def user_link(user)
    link_to(user.name, user)
  end

  def time(t)
    if t < 7.days.ago
      t.to_date.to_s
    else
      time_ago_in_words(t, include_seconds: true) + " ago"
    end
  end
end
