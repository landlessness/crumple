class Thought < ActiveRecord::Base  
  belongs_to :person
  belongs_to :project
  has_many :comments, :dependent => :destroy

  acts_as_taggable

  state_machine :initial => :active do
    event :archive do
      transition :active => :archived
    end

    event :activate do
      transition :archived => :active
    end

    event :put_in_drop_box do
      transition :active => :drop_box
    end

    event :accept do
      transition :drop_box => :active
    end
  end

end
