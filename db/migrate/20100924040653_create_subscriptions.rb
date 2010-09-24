class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.references :person
      t.references :pricing_plan
      t.timestamps
    end
  end
  
  def self.down
    drop_table :subscriptions
  end
end
