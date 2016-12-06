class AddStripeCustomerAndStripeChargeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :stripe_customer_id, :string
    add_column :registrations, :stripe_charge_id, :string
  end
end
