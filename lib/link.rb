class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end

  def details
    format_description(@description) + "site name: " + @site_name.to_s
  end
end
