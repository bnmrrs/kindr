module Kijiji
  class Item
    attr_reader :doc, :page

    def initialize(doc, page)
      @doc = doc
      @page = page
    end

    def external_id
      @external_id ||= doc.css('div[data-adid]').attr('data-adid').value
    end

    def url
      @url ||= doc.css('a.title').attr("href").to_s
    end

    def image_url
      @image_url ||= doc.css('img').attr('src').to_s
    end

    def large_image_url
      @large_image_url ||= image_url.sub('/$_2.', '/$_27.')
    end

    def title
      @title ||= doc.css('a.title').text.strip
    end

    def details
      @details ||= doc.css('.description p').map{ |p| p.text.strip }.join(" ")
    end

    def price
      @price ||= doc.css('.price').text.strip
    end

    def location
      page.location
    end

    def posted_at
      @posted_at ||= Chronic.parse(doc.css('td.posted').text.strip)
    end

    def raw
      doc.to_s
    end

    def attributes
      {
        external_id: external_id,
        url: url,
        image_url: image_url,
        title: title,
        details: details,
        price: price,
        location_name: location,
        posted_at: posted_at,
        raw_data: raw
      }
    end
  end
end
