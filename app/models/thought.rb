class Thought < ActiveRecord::Base  
  belongs_to :person
  belongs_to :project
  has_many :comments

  acts_as_taggable

  state_machine :initial => :active do
    event :archive do
      transition :active => :archived
    end

    event :activate do
      transition :archived => :active
    end

    event :put_in_dropbox do
      transition :active => :dropbox
    end

    event :accept do
      transition :dropbox => :active
    end
  end

end
