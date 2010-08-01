class DropBox < ActiveRecord::Base
  validates :name, :presence => true, 
                   :length => {:minimum => 2, :maximum => 254},
                   :uniqueness => true,
                   :format => {:with => /^([A-Z0-9]+)$/i}
                   
  validates :person, :presence => true

  belongs_to :person
  
  def self.name_and_secret_from_email(email)
    email.split('@').first.split('+').map {|t| t.strip.gsub(/[^A-Z0-9]+/i, '')}
  end
  
  def self.new_thought(send_grid_mail)
    project = nil
    
    name, secret = name_and_secret_from_email(send_grid_mail[:to])
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

    d.person.thoughts.build :body => send_grid_mail[:text], :project => project
  end

  def email
    self.name + '+' + self.secret + '@crumpleit.com'
  end

end
