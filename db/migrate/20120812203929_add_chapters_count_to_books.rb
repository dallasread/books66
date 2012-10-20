class AddChaptersCountToBooks < ActiveRecord::Migration
  def change
    add_column :books, :chapters_count, :integer, :default => 0
  end
end
