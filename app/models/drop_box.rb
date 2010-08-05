class DropBox < ActiveRecord::Base
  validates :name, :presence => true, 
                   :length => {:minimum => 2, :maximum => 254},
                   :uniqueness => true,
                   :format => {:with => /^([A-Z0-9]+)$/i}
                   
  validates :person, :presence => true

  belongs_to :person
  has_many :send_grid_emails

  def email_address
    self.name + '+' + self.secret + '@' + Rails.application.config.top_level_domain
  end

  def self.find_by_email_address(email_address)
    self.find_by_name_and_secret(*name_and_secret_from_email_address(email_address))
  end
  
  def self.name_and_secret_from_email_address(email_address)
    email_address = /[^A-Z]*(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))[^A-z]*/i.match(email_address)[1]
    email_address.split('@').first.split('+').map {|t| t.strip.gsub(/[^A-Z0-9]+/i, '')}
  end
  
  def process_email(email)
    # concat the subject and the body of the email
    body = email.subject + "\n\n" + email.text
    
    # find the project
    body.gsub!(/^[\s]*project:(.+)?[\s]*$[\n]?/i, '')
    project_name = $1.strip if $1    
    project = self.person.projects.where('projects.name ilike ?', project_name).first if project_name
    
    # get the tags
    body.gsub!(/^[\s]*tag[s]?:(.+)?[\s]*$[\n]?/i, '')
    tag_list = $1 if $1
    
    # create the thought
    thought = self.person.thoughts.create :origin => 'email', :body => body, :tag_list => tag_list, :project => project
    
    # put it in the drop dox
    thought.put_in_drop_box
    
    # update the original email so the thought can refer to it
    email.update_attributes :thought => thought
  end
  
end
