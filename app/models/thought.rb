class Thought < ActiveRecord::Base  
  include ActsAsVisualizable
  validates :body, :presence => true
  validates :person, :presence => true

  belongs_to :person
  belongs_to :project
  has_many :comments, :dependent => :destroy
  has_many :send_grid_emails

  acts_as_taggable

  state_machine :initial => :active do
    event :archive do
      transition [:active, :in_drop_box] => :archived
    end

    event :activate do
      transition :archived => :active
    end

    event :put_in_drop_box do
      transition :active => :in_drop_box
    end

    event :accept do
      transition :in_drop_box => :active
    end
  end

  def viz_node_name
    (project.nil? ? '' : "<strong>#{self.project.name}</strong><br/>") + self.body
  end

end

