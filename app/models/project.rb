class Project < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  has_many :members, :through => :memberships, :source => :person
  has_many :memberships, :dependent => :destroy
  has_many :thoughts, :dependent => :destroy
end
