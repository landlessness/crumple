class Thought < ActiveRecord::Migration
  def self.up
    add_column :thoughts, :state, :string, :default => 'active'
  end

  def self.down
    remove_column :thoughts, :state
  end
end
