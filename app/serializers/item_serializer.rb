class ItemSerializer < ActiveModel::Serializer
  attributes :id, :external_id, :image_url, :title, :details, :price, :location_name
end
