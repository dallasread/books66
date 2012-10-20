class CreateMargins < ActiveRecord::Migration
  def change
    create_table :margins do |t|
      t.string :ref
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
