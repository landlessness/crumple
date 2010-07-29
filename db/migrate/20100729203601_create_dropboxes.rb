class CreateDropboxes < ActiveRecord::Migration
  def self.up
    create_table :dropboxes do |t|
      t.references :person
      t.string :name
      t.string :secret

      t.timestamps
    end
  end

  def self.down
    drop_table :dropboxes
  end
end
