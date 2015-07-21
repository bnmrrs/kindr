class Item < ActiveRecord::Base
  validates :external_id, presence: true, uniqueness: true
  validates :url, :image_url, :title, :details, :location_name, presence: true
end
