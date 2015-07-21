class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :external_id, null: false, unique: true
      t.string :url, null: false
      t.string :image_url, null: false
      t.string :title, null: false
      t.text :details, null: false
      t.string :price
      t.string :location_name, null: false
      t.string :posted_at
      t.text :raw_data

      t.timestamps
    end
  end
end
