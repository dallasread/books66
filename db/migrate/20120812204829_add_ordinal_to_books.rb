class AddOrdinalToBooks < ActiveRecord::Migration
  def change
    add_column :books, :ordinal, :integer
  end
end
