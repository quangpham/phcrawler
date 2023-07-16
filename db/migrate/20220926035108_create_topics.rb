class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :name
      t.string :slug
      t.integer :parent_id
      t.integer :posts_count
      t.integer :followers_count
      t.integer :real_posts
    end
  end
end
