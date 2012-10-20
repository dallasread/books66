class AddTranslationIdToVerses < ActiveRecord::Migration
  def change
    add_column :verses, :translation_id, :integer
  end
end
