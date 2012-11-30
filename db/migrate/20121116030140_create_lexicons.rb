class CreateLexicons < ActiveRecord::Migration
  def change
    create_table :lexicons do |t|
      t.string :code
      t.string :orig_word
      t.string :word_orig
      t.string :translit
      t.string :tdnt
      t.string :phonetic
      t.string :part_of_speech
      t.text :st_def
      t.text :ipd_def
      t.string :dictionary

      t.timestamps
    end
    add_index :lexicons, :code
  end
end
