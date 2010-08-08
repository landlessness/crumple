class Comment < ActiveRecord::Base
  belongs_to :person
  belongs_to :thought
  validates :person, :presence => true
  validates :thought, :presence => true
end
