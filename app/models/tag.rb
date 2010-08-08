class Tag < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true
  has_many :taggings, :dependent => :destroy
  has_many :people, :through => :taggings, :uniq => true
  has_many :thoughts, :through => :taggings, :uniq => true
  
  cattr_accessor :delimiter
  self.delimiter = ' '
  
  def viz_node_value
    self.class.name + '_' + self.id.to_param
  end
  def viz_html_node_name
    'tag: <b>' + self.name + '</b>'
  end
  def viz_node_name
    'tag: ' + self.name
  end
end
