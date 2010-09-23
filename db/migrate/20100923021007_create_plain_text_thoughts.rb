class CreatePlainTextThoughts < ActiveRecord::Migration
  def self.up
    add_column :thoughts, :type, :string
  end

  def self.down
    remove_column :thoughts, :type
  end
end