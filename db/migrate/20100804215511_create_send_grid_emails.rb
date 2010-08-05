class CreateSendGridEmails < ActiveRecord::Migration
  def self.up
    create_table :send_grid_emails do |t|
      t.text :text
      t.text :html
      t.text :headers
      t.string :to
      t.string :from
      t.string :subject
      t.string :dkim
      t.integer :attachments
      t.references :drop_box
      t.references :thought
      t.boolean :assigned_drop_box

      t.timestamps
    end
  end

  def self.down
    drop_table :send_grid_emails
  end
end
