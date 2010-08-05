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
    project = self.person.projects.find_by_name(project_name) if project_name
    
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
  
  def self.new_thought(send_grid_mail)
    project = nil
    
    name, secret = name_and_secret_from_email_address(send_grid_mail[:to])
    d = DropBox.find_by_name_and_secret(name, secret)    
    
    if d.nil? || send_grid_mail[:text].nil?
      return nil
    else
      send_grid_mail[:text].strip!
    end

    unless send_grid_mail[:subject].nil? || send_grid_mail[:subject].empty?
      send_grid_mail[:subject].strip!
      project = d.person.projects.find_by_name(send_grid_mail[:subject])
      if project.nil?
        project = Project.new(:name => send_grid_mail[:subject])

        membership = d.person.memberships.build :project => project
      end
    end
    
    tag_list = 'email'
    body = send_grid_mail[:text].gsub(/^[\s]*tag[s]?:(.+)?[\s]*$[\n]?/i, '')
    tag_list += ' ' + $1 if $1

    d.person.thoughts.build :body => body, :project => project, :state_event => :put_in_drop_box, :tag_list => tag_list
  end

end
