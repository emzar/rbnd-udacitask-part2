module Listable
  def type
    self.class.to_s.gsub('Item', '')
  end

  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_date(dates, empty_message)
    dates.compact!
    return empty_message if dates.empty?
    dates.map! { |date| date.strftime("%D") }
    dates.join(' -- ')
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:green) if priority == "medium"
    value = " ⇩".colorize(:white) if priority == "low"
    value = "" if !priority
    value
  end
end
