class SendGridEmail < ActiveRecord::Base
  belongs_to :drop_box
  belongs_to :thought
  after_create :assign_drop_box

  def initialize(options={})
    logger.info 'options.to_yaml: ' + options.to_yaml
    options=remove_unknown_attributes(options)
    super
  end

  # to make this model robust enough to handle changes
  # from SendGrid we're going to remove all unknown attrs
  def remove_unknown_attributes(options)
    known_attributes = SendGridEmail.column_names
    options.stringify_keys.delete_if {|k,v| !known_attributes.include?(k)}.symbolize_keys
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
