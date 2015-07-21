module Kijiji
  class Page
    attr_reader :doc, :url

    def initialize(url)
      @url = URI(url)
      @doc = Nokogiri::HTML(open(url))
      @items = doc.css('.regular-ad:not(.third-party)')
    end

    def items
      @items.map { |item| Kijiji::Item.new(item, self) }
    end

    def location
      @location ||= doc.css('#LocationLabel').text.strip
    end

    def next_page
      next_page = doc.css('.pagination a[title="Next"]').attr('href').to_s
      Page.new(url.scheme + "://" + url.host + next_page)
    end
  end
end
