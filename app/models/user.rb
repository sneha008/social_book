class User < ActiveRecord::Base

  has_many :friends, :foreign_key => "user_id"
  has_many :posts, :order => "created_at desc"
  has_many :comments
  has_many :likes, :as => :likeable
  has_many :events, :foreign_key => "creator_id"
  has_many :event_users
  has_many :receiver_events, :through => :event_users, :source => :event
  has_many :shares, :foreign_key => "sharer_id"

  scope :wall_share, lambda{|id| Post.joins(:shares).where(["post.user_id == (?)",id])}

  after_create :reciprocate_friends

  def reciprocate_friends
    
  end
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname,
    :lastname, :education, :company, :homecity, :currentcity, :avatar

  has_attached_file :avatar,
      :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
      :url => "/system/:attachment/:id/:style/:filename",
      :styles =>
           { :medium => "300x300>", :thumb => "100x100>" }

end
