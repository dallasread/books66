class Verse < ActiveRecord::Base
  attr_accessible :body, :chapter_id, :number, :translation_id, :ref
  
  belongs_to :chapter
  has_one :book, :through => :chapter
  belongs_to :translation
  has_many :notes
  
  default_scope order(:number)
  
  def reference
    "#{book.name} #{chapter.number}:#{number}"
  end
  
  def self.text_search(q)
    if q.present?
      if q =~ /\d/
        where("body @@ :q or body like :p", q: q, p: "%#{q}%").includes(:book).order("books.ordinal asc, chapters.number asc, verses.number asc")
      else
        where("body @@ :q", q: q).includes(:book).order("books.ordinal asc, chapters.number asc, verses.number asc")
      end
    else
      scoped
    end
  end
end
