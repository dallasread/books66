class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :name
      t.string :permalink

      t.timestamps
    end
  end
end
