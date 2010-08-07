class MoveActsAsTaggableTables < ActiveRecord::Migration
  def self.up
    rename_table :tags, :old_tags
    rename_table :taggings, :old_taggings
  end

  def self.down
    rename_table :old_tags, :tags
    rename_table :old_taggings, :taggings
  end
end
