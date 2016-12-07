class AddShirtSizeToRegistrationMembers < ActiveRecord::Migration
  def change
    add_column :registration_members, :shirt_size, :string
  end
end
