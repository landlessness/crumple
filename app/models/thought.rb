class Thought < ActiveRecord::Base  
  belongs_to :person
  belongs_to :project

  acts_as_taggable
  
  state_machine :initial => :active do
    event :archive do
      transition :active => :archived
    end
    
    event :activate do
      transition :archived => :active
    end
  end

end
