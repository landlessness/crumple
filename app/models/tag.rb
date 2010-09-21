class Tag < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true
  has_many :taggings, :dependent => :destroy
  has_many :people, :through => :taggings, :uniq => true
  has_many :thoughts, :through => :taggings, :uniq => true
  
  cattr_accessor :delimiter
  self.delimiter = ' '
  
end
