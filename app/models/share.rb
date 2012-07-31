class Share < ActiveRecord::Base

  belongs_to :user, :foreign_key => "sharer_id"
  belongs_to :post
end
