class SendGridEmail < ActiveRecord::Base
  belongs_to :drop_box
  belongs_to :thought
  after_create :assign_drop_box

  # to make this model robust enough to handle changes
  # from SendGrid we're going to remove all unknown attrs
  def self.remove_unknown_attributes(params)
    known_attributes = SendGridEmail.column_names
    params.stringify_keys!.delete_if {|k,v| !known_attributes.include?(k)}
    params.symbolize_keys
  end

  def assign_drop_box
    if drop_box = DropBox.find_by_email_address(self.to)
      self.update_attributes :assigned_drop_box => true, :drop_box => drop_box
      self.drop_box.process_email self
    else
      self.update_attributes :assigned_drop_box => false
    end
  end

  class MissingDropBoxError < RuntimeError
  end
end
