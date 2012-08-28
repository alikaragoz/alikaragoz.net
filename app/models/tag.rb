class Tag < ActiveRecord::Base
	# FriendlyId is used for generating friendly urls
  extend FriendlyId
  
  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings
  attr_accessible :name, :slug
  	
	# Here we use the slug column
  friendly_id :name, use: :slugged
end
