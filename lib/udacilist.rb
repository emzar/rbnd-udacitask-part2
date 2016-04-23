class UdaciList
  attr_reader :title, :items

  ITEMS_TYPES = %w[todo event link].freeze

  def initialize(options={})
    title = options[:title] || 'Untitled List'
    @table_options =
      {
        title: title,
        headings: [ { value: '#', alignment: :right}, 'Type', 'Details' ]
      }
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
    table(@items)
  end

  def filter(item_type)
    filtered_items = @items.select { |item| item.type == item_type }
    if filtered_items.empty?
      puts "There aren't any items of #{item_type} type"
    else
      table(filtered_items)
    end
  end

  def delete_if(item_type)
    @items.delete_if { |item| item.type == item_type }
  end

  private

  def table(items)
    rows = items.map.with_index { |item, position| [position + 1, item.type, item.details] }
    table = Terminal::Table.new(@table_options.merge(rows: rows))
    table.align_column(0, :right)
    puts table
  end
end
