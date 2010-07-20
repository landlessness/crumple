class Thought < ActiveRecord::Base
  belongs_to :creator
  belongs_to :project
end
