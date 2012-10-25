class AddRefToVerses < ActiveRecord::Migration
  def change
    add_column :verses, :ref, :string
  end
end
