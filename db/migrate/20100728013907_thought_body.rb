class ThoughtBody < ActiveRecord::Migration
  def self.up
    rename_column :thoughts, :typing, :body
  end

  def self.down
    rename_column :thoughts, :body, :typing
  end
end
