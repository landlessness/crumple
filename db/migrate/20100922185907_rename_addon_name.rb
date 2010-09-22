class RenameAddonName < ActiveRecord::Migration
  def self.up
    rename_column :add_ons, :underscored_name, :element_name
    
  end

  def self.down
    rename_column :add_ons, :element_name, :underscored_name
  end
end
