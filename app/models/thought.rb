class Thought < ActiveRecord::Base
  belongs_to :person
  belongs_to :project

  acts_as_taggable

end
