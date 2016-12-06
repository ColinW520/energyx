class CreateRegistrationMembers < ActiveRecord::Migration
  def change
    create_table :registration_members do |t|
      t.references :registration, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
