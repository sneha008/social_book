class EventUser < ActiveRecord::Base

  belongs_to :event
  belongs_to :user, :foreign_key => "user_id"
end
