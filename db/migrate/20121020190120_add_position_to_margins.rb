class AddPositionToMargins < ActiveRecord::Migration
  def change
    add_column :margins, :position, :string
  end
end
