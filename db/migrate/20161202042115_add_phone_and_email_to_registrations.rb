class AddPhoneAndEmailToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :phone, :string
    add_column :registrations, :email, :string
  end
end
