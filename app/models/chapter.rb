class Chapter < ActiveRecord::Base
  attr_accessible :book_id, :number
  
  belongs_to :book, counter_cache: true
  has_many :verses
  
  def next
    @next = book.chapters.find_by_number(number + 1)
    
    if book.ordinal == 66 && number == 22
      @next = nil
    elsif !@next
      b = Book.find_by_ordinal(book.ordinal + 1)
      @next = b.chapters.find_by_number(1)
    end
    
    @next
  end
  
  def prev
    if book.ordinal == 1 && number == 1
      @prev = nil
    elsif number == 1
      b = Book.find_by_ordinal(book.ordinal - 1)
      @prev = b.chapters.order("number desc").first
    else
      @prev = book.chapters.find_by_number(number - 1)
    end
    
    @prev
  end
  
  def short_reference
    "#{book.short_name} #{number}"
  end
  
  def full_reference
    "#{book.name} #{number}"
  end
end
