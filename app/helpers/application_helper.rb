module ApplicationHelper
  def user_link(user)
    link_to("@#{user.name}", user)
  end

  def time(t)
    if t < 7.days.ago
      t.to_date.to_s
    else
      time_ago_in_words(t, include_seconds: true) + " ago"
    end
  end

  def chirp_body(chirp)
    known_mentions = chirp.mentions.index_by { |u| u.name.downcase }

    output = "".html_safe
    mention = /(?<!\w)@(\w+)/

    scanner = StringScanner.new(chirp.content)
    previous_pos = 0
    while scanner.scan_until(mention)
      output << scanner.pre_match[previous_pos..-1]

      if user = known_mentions[scanner[1].downcase]
        output << user_link(user)
      else
        # Not a real mention
        output << scanner[0]
      end

      previous_pos = scanner.pos
    end

    output << scanner.rest

    output
  end
end
