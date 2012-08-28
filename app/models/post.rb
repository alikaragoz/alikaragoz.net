class Post < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  attr_accessible :body, :slug, :status, :title, :tag_names

  validates_presence_of :title, :tag_names, :body
  
  # FriendlyId is used for generating friendly urls
	extend FriendlyId
	# Here we use the slug column
  friendly_id :title, use: :slugged

  # Tags setters
  def tag_names
    tags.map(&:name).join(', ')
  end
  
  def tag_names=(names)
    self.tags = names.split(',').map do |name|
      Tag.find_or_create_by_name(name.strip)
    end
  end 

  def previous
    self.class.where('created_at < ?', created_at).where(:status => :true).order('created_at DESC').first
  end

  def next
    self.class.where('created_at > ?', created_at).where(:status => :true).order('created_at ASC').first
  end
end