class UdaciList
  attr_reader :title, :items

  ITEMS_TYPES = %w[todo event link].freeze

  def initialize(options={})
    title = options[:title] || 'Untitled List'
    @table = Terminal::Table.new(
      title: title,
      headings: [ { value: '#', alignment: :right}, 'desc' ]
    )
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    raise UdaciListErrors::InvalidItemType.new unless ITEMS_TYPES.include?(type)
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSize.new unless @items.delete_at(index - 1)
  end

  def all
    @items.each_with_index do |item, position|
      @table.add_row([position + 1, item.details])
    end
    @table.align_column(0, :right)
    puts @table
  end
end
