class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  PRIORITIES = %w[low medium high].freeze

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(Chronic.parse(options[:due]).to_s) : options[:due]
    @priority = options[:priority]
    if @priority && !PRIORITIES.include?(options[:priority])
      raise UdaciListErrors::InvalidPriorityValue.new
    end
  end

  def details
    format_description(@description) + "due: " +
    format_date([@due], "No due date") +
    format_priority(@priority)
  end
end
