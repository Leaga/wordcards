class User < ActiveRecord::Base
  attr_accessible :name, :twitter_name
  has_many :tags
  has_many :cards
end
