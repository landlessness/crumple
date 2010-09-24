class CreatePricingPlans < ActiveRecord::Migration
  def self.up
    create_table :pricing_plans do |t|
      t.references :add_on
      t.integer :monthly_fee_cents
      t.string :name
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :pricing_plans
  end
end
