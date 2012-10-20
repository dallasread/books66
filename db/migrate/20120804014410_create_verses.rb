class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.integer :number
      t.integer :chapter_id
      t.text :body

      t.timestamps
    end
  end
end
