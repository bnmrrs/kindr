module Kijiji
  class Importer
    attr_reader :url, :imported_items

    def initialize(url)
      @url = url
      @imported_items = []
    end

    def import(item_limit: 100, page_limit: 10)
      imported_pages = []
      page = Kijiji::Page.new(url)

      while item_limit <= item_limit && imported_pages.count <= page_limit  do
        imported_pages << import_page(page, item_limit)
        page = page.next_page
      end
    end

  protected

    def import_page(page, limit)
      page.items.first(remaining_to_import(limit)).map { |i| import_item(i) }
    end

    def import_item(item)
      if should_import?(item)
        puts "Importing #{item.external_id}"
        @imported_items << ::Item.create!(item.attributes)
      else
        puts "Skipping #{item.external_id}"
      end
    rescue Exception => e
      puts "Failed to import #{item.external_id} - #{e.message}"
    end

    def should_import?(item)
      !::Item.where(external_id: item.external_id).exists?
    end

    def remaining_to_import(limit)
      limit - imported_items.count
    end
  end
end
