class AddOnThought < ActiveResource::Base
  def self.find_by_add_on_and_id(add_on, id)
    add_on = AddOn.find_by_element_name(add_on)
    clazz = Class.new(AddOnThought){self.site = add_on.site; self.element_name = add_on.element_name}
    clazz.find(id)
  end
end
