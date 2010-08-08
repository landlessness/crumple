class Membership < ActiveRecord::Base
  belongs_to :person
  belongs_to :project
  validates :person, :presence => true
  validates :project, :presence => true
end

