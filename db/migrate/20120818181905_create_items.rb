class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :variation
      t.integer :item_id
      t.string :ref
      t.integer :ordinal

      t.timestamps
    end
  end
end
