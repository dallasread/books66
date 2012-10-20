class AddAbbrToBooks < ActiveRecord::Migration
  def change
    add_column :books, :abbr, :string
  end
end
