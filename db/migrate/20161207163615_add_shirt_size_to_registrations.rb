class AddShirtSizeToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :shirt_size, :string
  end
end
