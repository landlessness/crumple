class CreateAddOns < ActiveRecord::Migration
  def self.up
    create_table :add_ons do |t|
      t.string :name
      t.text :description
      t.references :person
      t.timestamps
    end
  end
  
  def self.down
    drop_table :add_ons
  end
end
