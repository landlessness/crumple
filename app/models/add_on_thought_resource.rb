class AddOnThoughtResource < ActiveResource::Base
  self.format = :json

  def self.subclazz_for(add_on)
    if Object.const_defined?(add_on.element_resource_class_name)
      add_on.element_resource_class_name.constantize
    else
      clazz = Class.new(AddOnThoughtResource) do
        self.site = add_on.site
        self.element_name = add_on.element_name
      end
      Object.const_set add_on.element_resource_class_name, clazz
    end
  end

end