class CreatePlatforms < ActiveRecord::Migration
  def self.up
    create_table :platforms do |t|
      t.string :name
      t.string :app_secret
      t.string :api_key
      t.string :app_id
      t.string :app_url

      t.timestamps
    end
  end

  def self.down
    drop_table :platforms
  end
end
