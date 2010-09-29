class AddAddOnToThoughts < ActiveRecord::Migration
  def self.up
    add_column :thoughts, :add_on_id, :integer
    add_column :thoughts, :add_on_thought_resource_id, :integer
  end

  def self.down
    remove_column :thoughts, :add_on_id
    remove_column :thoughts, :add_on_thought_resource_id
  end
end
