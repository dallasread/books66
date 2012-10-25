class Margin < ActiveRecord::Base
  attr_accessible :body, :ref, :user_id, :position
  
  belongs_to :user
  
  validates_presence_of :position, :ref
  
  before_save do
    body = "" if body == "<br>"
  end
  
  after_save do
    verse.touch
  end
  
  def verse
    Verse.where(ref: ref).first
  end
end
