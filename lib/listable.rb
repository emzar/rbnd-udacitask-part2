module Listable
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_date(dates, empty_message)
    dates.compact!
    return empty_message if dates.empty?
    dates.map! { |date| date.strftime("%D") }
    dates.join(' -- ')
  end
end
