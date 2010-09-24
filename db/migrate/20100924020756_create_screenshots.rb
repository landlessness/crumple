class CreateScreenshots < ActiveRecord::Migration
  def self.up
    create_table :screenshots do |t|
      t.references :add_on
      t.string :image_url
      t.string :name
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :screenshots
  end
end
