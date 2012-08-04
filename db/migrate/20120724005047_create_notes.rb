class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :story_id
      t.integer :user_id
      t.text :body
      t.integer :ordinal

      t.timestamps
    end
  end
end
