class GenerateVerseRefs < ActiveRecord::Migration
  def change
    for verse in Verse.all
      verse.update_attributes ref: verse.reference
    end
  end
end
