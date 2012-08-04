class Note < ActiveRecord::Base
  attr_accessible :body, :ordinal, :story_id, :user_id
end
