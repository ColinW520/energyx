class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.boolean :is_paid
      t.string :name
      t.string :subtype

      t.timestamps null: false
    end
  end
end
