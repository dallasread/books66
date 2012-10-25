class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :name, :avatar
  
  has_many :stories
  has_many :followships
  has_many :follows, :through => :followships
  has_many :margins
  
  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :inverse_followships, :class_name => "Followship", :foreign_key => "follow_id"
  has_many :inverse_follows, :through => :inverse_followships, :source => :user
  
  has_many :favourites
  
  default_scope order("created_at desc")
  
  has_attached_file :avatar,
                    :url => "/avatars/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/avatars/:id/:style/:basename.:extension",
                    :default_url => "/assets/generic.jpg",
                    :styles => {
                          :thumb => ['75x75#', :jpeg]
                        }
                        
  def followed_stories
    Story.find_all_by_user_id(self.follows.map{ |f| f.id })
  end
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.nickname + "@66books.co"
      user.name = auth.info.name
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
