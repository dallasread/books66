class Followship < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :follow_id, :user_id

  belongs_to :user
  belongs_to :follow, :class_name => "User"
end
