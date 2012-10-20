class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :number
      t.integer :book_id

      t.timestamps
    end
  end
end
