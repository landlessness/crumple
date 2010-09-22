class AddPathToAddOns < ActiveRecord::Migration
  def self.up
    add_column :add_ons, :underscored_name, :string
    add_column :add_ons, :site, :string
    add_column :add_ons, :type, :string
  end

  def self.down
    remove_column :add_ons, :underscored_name
    remove_column :add_ons, :site
    remove_column :add_ons, :type
  end
end
