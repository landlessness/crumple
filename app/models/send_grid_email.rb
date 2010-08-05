class SendGridEmail < ActiveRecord::Base
  belongs_to :drop_box
  belongs_to :thought
  after_create :assign_drop_box

  def assign_drop_box
    if drop_box = DropBox.find_by_email_address(self.to)
      self.update_attributes :assigned_drop_box => true, :drop_box => drop_box
    else
      self.update_attributes :assigned_drop_box => false
      raise 'unable to find drop box'
    end
    self.drop_box.process_email self
  end
  
end
