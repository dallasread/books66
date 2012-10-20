class Item < ActiveRecord::Base
  attr_accessible :item_id, :ordinal, :ref, :variation, :story_id
  
  belongs_to :story
  
  def reify
    if variation == "note"
      Note.find(item_id)
    elsif variation == "verse"
      ref_split = ref.split(" ")
      numbers = ref_split.last
      numbers_split = numbers.split(":")
      verse_number = numbers_split.last
      chapter_number = numbers_split.first
      book_name = ref.gsub(" " + numbers, "")
      book = Book.find_by_name(book_name)
      chapter = book.chapters.find_by_number(chapter_number)
      verse = chapter.verses.find_by_number(verse_number)
      verse
    end
  end
end
