class User < ActiveRecord::Base
  has_many :past_actions
end
