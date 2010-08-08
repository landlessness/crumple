class Project < ActiveRecord::Base
  has_many :members, :through => :memberships, :source => :person
  has_many :memberships, :dependent => :destroy
  has_many :thoughts, :dependent => :destroy

  def self.tags
    
  end
end
