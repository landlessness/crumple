class Project < ActiveRecord::Base
  has_many :people, :through => :memberships
  has_many :memberships, :dependent => :destroy
  has_many :thoughts, :dependent => :destroy
end
