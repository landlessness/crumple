class AddOn < ActiveRecord::Base
  belongs_to :developer, :class_name => 'Person', :foreign_key => 'person_id'
end
