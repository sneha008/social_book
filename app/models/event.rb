class Event < ActiveRecord::Base

  belongs_to :user, :foreign_key => "creator_id"
  has_many :event_users
  attr_accessible :name, :description, :venue, :creator_id, :start_datetime,
                  :end_datetime, :event_id, :user_id, :event_users_attributes
                  
  accepts_nested_attributes_for :event_users
end
