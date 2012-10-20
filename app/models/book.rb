class Book < ActiveRecord::Base
  attr_accessible :name, :permalink, :ordinal, :chapters_count
  
  has_many :chapters
  
  def to_param
    self.permalink
  end
  
  def short_name
    name.gsub(" ", "").gsub("II", "2").gsub("I", "1")[0..2]
  end
end
