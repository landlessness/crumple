class Project < ActiveRecord::Base
  has_many :members, :through => :memberships, :source => :person
  has_many :memberships, :dependent => :destroy
  has_many :thoughts, :dependent => :destroy

  def tags
    Tag.joins(:thoughts).where(:thoughts => {:project_id => self}).select('DISTINCT tags.*')
  end
  def taggings
    Tagging.joins(:thought).where(:thoughts => {:project_id => self})
  end
end
