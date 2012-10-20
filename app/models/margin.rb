class Margin < ActiveRecord::Base
  attr_accessible :body, :ref, :user_id, :position
  
  belongs_to :user
  
  validates_presence_of :position, :ref
end
