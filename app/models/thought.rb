class Thought < ActiveRecord::Base  
  cattr_reader :per_page
  @@per_page = 10

  searchable do
    text :body, :boost => 2.0
    text :tags_list, :project_name
    integer :person_id
    date :updated_at
    string :state
  end

  # Sunspot.remove_all
  # Sunspot.index(Thought.all)
  # r = Sunspot.search(Thought) {keywords 'crumple', :fields => [:body]}.results
    
  validates :body, :presence => true
  validates :person, :presence => true

  belongs_to :person
  belongs_to :project
  has_many :comments, :dependent => :destroy
  has_many :send_grid_emails
  
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings, :uniq => true

  def tags_list=(tags_string)
    return unless tags_string
    
    # this is to assist with the thoughts#new before signing in
    @tags_list_string = tags_string
    
    # TODO this is ugly code. clean it up.
    taggings_to_create = tags_array = tag_names_from_string(tags_string)

    unless self.taggings.empty?
      newly_requested_taggings_that_already_exist = self.taggings.joins(:tag).where(:tags=>{:name => tags_array}, :person_id => self.person.id)
      taggings_to_delete = self.taggings - newly_requested_taggings_that_already_exist
      Tagging.delete(taggings_to_delete.map(&:id))
      taggings_to_create = tags_array - newly_requested_taggings_that_already_exist.map {|t| t.tag.name}
    end

    add_tags(taggings_to_create)
  end
  
  def tags_list
    tags.empty? ? tags_list_string : self.tags.map(&:name).join(Tag.delimiter)
  end

  def tags_list_string
    @tags_list_string || ''
  end

  def tags_list_concat=(tags_string)
    add_tags(tag_names_from_string(tags_string))
  end
  def tags_list_concat
    ''
  end

  def project_name
    project.nil? ? '' : project.name
  end

  state_machine :initial => :active do
    event :archive do
      transition [:active, :in_drop_box] => :archived
    end

    event :activate do
      transition :archived => :active
    end

    event :put_in_drop_box do
      transition :active => :in_drop_box
    end

    event :accept do
      transition :in_drop_box => :active
    end
  end

  def viz_html_node_name
    (project.nil? ? '' : "<strong>#{self.project.name}</strong><br/>") + self.body
  end
  def viz_node_name
    (project.nil? ? '' : "#{self.project.name}: ") + self.body
  end
  def viz_node_value
    self.class.name + '_' + self.id.to_s
  end
  protected
  def tag_names_from_string(tags_string)
    (tags_string||'').split(Tag.delimiter)
  end
  def add_tags(tag_names)
    tag_names.each do |t|
      tag = Tag.find_or_create_by_name t
      self.taggings.build :tag => tag, :person => self.person
    end    
  end
end
