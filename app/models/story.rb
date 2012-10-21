class Story < ActiveRecord::Base
  attr_accessible :name, :user_id, :permalink
  
  belongs_to :user
  
  has_many :favourites
  has_many :items
  has_many :notes
  
  validates_presence_of :name
  validates_uniqueness_of :permalink, scope: :user_id
  
  before_validation do
    if self.new_record?
      self.permalink = self.name.parameterize
    end
  end
  
  default_scope order("updated_at desc")
  
  def to_param
    permalink
  end
end
