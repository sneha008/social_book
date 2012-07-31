class Post < ActiveRecord::Base  
  has_many :likes, :as => :likeable
  has_many :comments
  belongs_to :user
  has_many :shares

  scope :from_5_days, :conditions => ["created_at < '#{5.days.from_now}'"]

  scope :user_friends_post, lambda {|userid| where(["user_id in (?)",userid])}
end
