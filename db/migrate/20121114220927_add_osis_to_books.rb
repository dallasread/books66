class AddOsisToBooks < ActiveRecord::Migration
  def change
    add_column :books, :osis, :string
  end
end
