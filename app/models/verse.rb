class Verse < ActiveRecord::Base
  attr_accessible :body, :chapter_id, :number, :translation_id
  
  belongs_to :chapter
  has_one :book, :through => :chapter
  belongs_to :translation
  
  default_scope order(:number)
  
  def reference
    "#{book.name} #{chapter.number}:#{number}"
  end
  
  def self.text_search(q)
    if q.present?
      where("body @@ :q", q: q).includes(:book).order("books.ordinal asc, chapters.number asc, verses.number asc")
    else
      scoped
    end
  end
end
