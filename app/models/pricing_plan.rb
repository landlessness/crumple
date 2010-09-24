class PricingPlan < ActiveRecord::Base
  belongs_to :add_on
  def monthly_fee
    safe(monthly_fee_cents) / 100.0
  end
  def monthly_fee=(fee)
    write_attribute(:monthly_fee_cents, (safe(fee).to_f * 100).to_i)
  end
  private
  def safe(fee)
    fee && fee > 0 ? fee : 0
  end
end
