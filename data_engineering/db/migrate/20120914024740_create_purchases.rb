class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :count
      t.references :item
      t.references :purchaser

      t.timestamps
    end
    add_index :purchases, :item_id
    add_index :purchases, :purchaser_id
  end
end
