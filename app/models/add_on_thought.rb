class AddOnThought < Thought
  belongs_to :add_on
  validates :add_on, :presence => true, :is_a_thought_add_on => true

  # these methods will act like belongs_to for active resource
  #  http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#method-i-belongs_to
  def add_on_thought_resource(force_reload=false)
    @add_on_thought_resource || add_on_thought_resource_clazz.find(self.add_on_thought_resource_id)
  end

  def add_on_thought_resource=(associate)
    @add_on_thought_resource = associate
    self.add_on_thought_resource_id = associate.id
  end

  def build_add_on_thought_resource(attributes={})
    add_on_thought_resource_clazz.new attributes.merge(:add_on => self.add_on)
  end

  def create_add_on_thought_resource(attributes={})
    add_on_thought_resource_clazz.create attributes.merge(:add_on => self.add_on)
  end

  def add_on_thought_resource_clazz
    AddOnThoughtResource.subclazz_for(self.add_on)
  end

  def self.subclazz_new(options)
    subclazz(options[:add_on]).new options
  end
  def self.subclazz_create(options)
    subclazz(options[:add_on]).create options
  end
  def self.subclazz(add_on)
    if Object.const_defined?(add_on.element_class_name)
      
      add_on.element_class_name.constantize
    else
      raise AddOnTypeMismatch unless add_on.is_a?(ThoughtAddOn)
      clazz = Object.const_set(add_on.element_class_name, Class.new(AddOnThought))
      clazz.class_eval do
        define_method (add_on.element_name + '=').to_sym do |options|
          # TODO: make the call to active resource
          # and store the id 
          #  should I call create or update?
          # thought = active_resource.create options
          # write_attribute :foreign_thought_id, thought.to_param
        end
        define_method (add_on.element_name).to_sym do
          # TODO: make the call to active resource
        end
      end
      clazz
    end
  end
end

class AddOnTypeMismatch < Exception; end
