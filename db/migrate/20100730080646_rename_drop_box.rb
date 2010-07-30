class RenameDropBox < ActiveRecord::Migration
  def self.up
    rename_table :dropboxes, :drop_boxes
  end

  def self.down
    rename_table :drop_boxes, :dropboxes
  end
end
