class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :slug
      t.string :tagline
      t.string :pricing_type
      t.integer :comments
      t.integer :reviews
      t.decimal :rating
      t.integer :votes
      t.integer :product_id
      t.integer :topic_ids, array: true
      t.boolean :dws
      t.datetime :feature_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end