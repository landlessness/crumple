class AddOnThought < ActiveResource::Base
  def self.subclazz_for(add_on_element_name)
    add_on = AddOn.find_by_element_name(add_on_element_name)
    clazz = Class.new(AddOnThought){self.site = add_on.site; self.element_name = add_on.element_name}
  end
end
