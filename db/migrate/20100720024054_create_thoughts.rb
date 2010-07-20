class CreateThoughts < ActiveRecord::Migration
  def self.up
    create_table :thoughts do |t|
      t.text :typing
      t.references :creator
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :thoughts
  end
end
