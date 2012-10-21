class Item < ActiveRecord::Base
  attr_accessible :item_id, :ordinal, :ref, :variation, :story_id
  
  belongs_to :story
  
  default_scope order(:ordinal)
  
  def reify
    if variation == "note"
      item = Note.find(ref)
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
      item = verse
    end
    item
  end
end
