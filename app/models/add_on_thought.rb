class AddOnThought < ActiveResource::Base
  self.format = :json
  
  def self.subclazz_for(add_on_element_name)
    add_on = AddOn.find_by_element_name(add_on_element_name)
    clazz = Class.new(AddOnThought) do
      self.site = add_on.site
      self.element_name = add_on.element_name
    end
  end
end
