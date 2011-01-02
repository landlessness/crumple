class AddOnThought < Thought
  belongs_to :add_on
  validates :add_on, :presence => true, :is_a_thought_add_on => true
  before_create :create_resource
  before_update :update_resource
  before_destroy :destroy_resource
  @resource_attributes={}  
  def search_text
    add_on_thought_resource.search_text
  end
  def body
    add_on_thought_resource.body
  end
  def create_resource
    logger.info '!!! create_resource'
    raise AddOnResourceAttributesMissing, 'the resource attributes were not set. probably because the options hash did not have the key: ' + self.add_on.element_name if @resource_attributes.nil?
    self.add_on_thought_resource = add_on_thought_resource_clazz.create(@resource_attributes)
  end
  def update_resource
    raise AddOnResourceAttributesMissing, 'the resource attributes were not set. probably because the options hash did not have the key: ' + self.add_on.element_name if @resource_attributes.nil?
    self.add_on_thought_resource.update_attributes @resource_attributes
  end
  def destroy_resource
    self.add_on_thought_resource.destroy
  end
  def add_on_thought_resource(force_reload=false)
    logger.info '@add_on_thought_resource: ' + @add_on_thought_resource.to_yaml
    logger.info 'self.add_on_thought_resource_id: ' + self.add_on_thought_resource_id.to_param
    r = @add_on_thought_resource || @add_on_thought_resource = AddOnThoughtResource.find(self.add_on_thought_resource_id) rescue nil
    if r.nil?
      raise AddOnResourceMissing, 'the add on resource is missing for ' + self.add_on.element_name.classify + 'Resource'
    else
      r
    end
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
    logger.info '!!! self.subclazz_new(options)'
    subclazz(options[:add_on]).new options
  end
  def self.subclazz_create(options)
    subclazz(options[:add_on]).create options
  end
  def self.subclazz_create!(options)
    subclazz(options[:add_on]).create! options
  end
  def self.subclazz(add_on)
    logger.info '!!! self.subclazz(add_on)'
    raise AddOnMissing unless add_on
    if Object.const_defined?(add_on.element_class_name)
      add_on.element_class_name.constantize
    else
      raise AddOnTypeMismatch unless add_on.is_a?(ThoughtAddOn)
      clazz = Object.const_set(add_on.element_class_name, Class.new(AddOnThought))
      clazz.class_eval do
        # TODO: should i use accepts nested attributes?
        define_method (add_on.element_name + '=').to_sym do |options|
          @resource_attributes = @resource_attributes ? @resource_attributes.merge(options) : options
          logger.info '!!! @resource_attributes: ' + @resource_attributes.to_yaml
        end
        define_method (add_on.element_name).to_sym do
        end
      end
      clazz
    end
  end
end

class AddOnTypeMismatch < Exception; end
class AddOnMissing < Exception; end
class AddOnResourceAttributesMissing < Exception; end
class AddOnResourceMissing < Exception; end
