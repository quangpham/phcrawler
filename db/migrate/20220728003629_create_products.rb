class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :slug
      t.integer :post_ids, array: true
    end
  end
end
