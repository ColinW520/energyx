class CreateSocialPosts < ActiveRecord::Migration
  def change
    create_table :social_posts do |t|
      t.string :link
      t.text :oembed
      t.string :service
      t.string :service_id

      t.timestamps null: false
    end
  end
end
