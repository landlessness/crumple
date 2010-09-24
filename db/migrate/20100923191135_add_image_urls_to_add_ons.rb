class AddImageUrlsToAddOns < ActiveRecord::Migration
  def self.up
    add_column :add_ons, :icon_512_url, :string
    add_column :add_ons, :icon_57_url, :string
    add_column :add_ons, :icon_29_url, :string
    add_column :add_ons, :icon_29_subtle_url, :string
  end

  def self.down
    remove_column :add_ons, :icon_29_url
    remove_column :add_ons, :icon_57_url
    remove_column :add_ons, :icon_512_url
    remove_column :add_ons, :icon_29_subtle_url
  end
end