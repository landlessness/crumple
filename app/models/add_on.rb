class AddOn < ActiveRecord::Base
  belongs_to :developer, :class_name => 'Person', :foreign_key => 'person_id'
  has_many :pricing_plans, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
  has_many :add_on_thoughts, :dependent => :destroy
  
  accepts_nested_attributes_for :pricing_plans
  def element_class_name
    element_name.classify
  end
  def element_resource_class_name
    element_class_name + 'Resource'
  end
end
