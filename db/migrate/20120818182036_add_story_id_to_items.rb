class AddStoryIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :story_id, :integer
  end
end
