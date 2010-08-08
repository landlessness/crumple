class Tagging < ActiveRecord::Base
  belongs_to :thought
  belongs_to :tag
  belongs_to :person
end
