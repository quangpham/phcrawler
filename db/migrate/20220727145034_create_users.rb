class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :headline
      t.string :twitter
      t.string :website
      t.boolean :is_viewer
      t.boolean :is_maker
      t.boolean :is_trashed
      t.integer :badges
      t.integer :followers
      t.integer :following
      t.integer :score
      t.integer :maker_ids, array: true
      t.integer :hunter_ids, array: true
      t.integer :commenter_ids, array: true
      t.integer :upvoter_ids, array: true
      t.datetime :created_at
    end
  end
end
