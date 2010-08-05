class AddOriginToThoughts < ActiveRecord::Migration
  def self.up
    add_column :thoughts, :origin, :string
  end

  def self.down
    remove_column :thoughts, :origin
  end
end
