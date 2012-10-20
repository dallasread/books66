class Translation < ActiveRecord::Base
  attr_accessible :name, :permalink
  
  has_many :verses
  
  def to_param
    self.permalink
  end
end
