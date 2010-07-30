class DropBox < ActiveRecord::Base

  belongs_to :person
  
  def self.name_and_secret_from_email(email)
    email.split('@').first.split('+')
  end
  
  def self.new_thought(send_grid_mail)
    t = nil
    name, secret = name_and_secret_from_email(send_grid_mail[:to])
    d = DropBox.find_by_name_and_secret(name, secret)
    unless d.nil?
      project = nil
      unless send_grid_mail[:subject].strip!.nil? || send_grid_mail[:subject].empty?
        # ilike it postgres for case insensitive like
        project = d.person.projects.where('name ilike ?', send_grid_mail[:subject])
        if project.nil?
          project = Project.new(:name => send_grid_mail[:subject])
          membership = d.person.memberships.new
          membership.project = @project
        end
      end
      t = d.person.thoughts.create! :body => send_grid_mail[:text].strip!, :project => project
      t.put_in_drop_box
    end
    t
  end

  def self.process_email(mail)
    name, secret = mail.to.first.split('@').first.split('+')
    d = DropBox.find_by_name_and_secret(name, secret)
    body = ''
    if mail.parts.empty?
      body = mail.body.to_s.strip
    else
      mail.parts.each do |part|
        body = part.body.to_s.strip if part.content_type.include?('text/plain')
      end
    end
    project = nil
    unless mail.subject.nil? || mail.subject.empty?
      project = d.person.projects.where('name like ?', mail.subject).first
      if project.nil?
        project = Project.new(:name => mail.subject)
        membership = d.person.memberships.new
        membership.project = @project
        project.save!
        membership.save!
      end
    end
    t = d.person.thoughts.create! :body => body, :project => project
    t.put_in_drop_box
    raise "thought, #{t.body}, was not created for person, #{d.person.email}. errors: #{t.errors.full_messages.to_s}" if t.nil?
    t
  end
  
  def email
    self.name + '+' + self.secret + '@crumpleit.com'
  end

end
