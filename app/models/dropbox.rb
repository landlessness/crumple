class Dropbox < ActiveRecord::Base

  belongs_to :person

  def self.process_email(mail)
    name, secret = mail.to.first.split('@').first.split('+')
    d = Dropbox.find_by_name_and_secret(name, secret)
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
    t.put_in_dropbox
    raise "thought, #{t.body}, was not created for person, #{d.person.email}. errors: #{t.errors.full_messages.to_s}" if t.nil?
    t
  end

end
