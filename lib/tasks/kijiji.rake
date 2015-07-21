namespace :kijiji do
  desc "Scrape Kijiji"
  task get_new_items: :environment do
    url = "http://www.kijiji.ca/b-buy-sell/kitchener-waterloo/c10l1700212"
    importer = Kijiji::Importer.new(url)
    importer.import
  end
end
