class Project < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  has_many :members, :through => :memberships, :source => :person
  has_many :memberships, :dependent => :destroy
  has_many :thoughts, :dependent => :destroy

  def tags(state)
    Tag.joins(:thoughts).where(:thoughts => {:project_id => self, :state => state.to_s}).select('DISTINCT tags.*')
  end
  def taggings(state)
    Tagging.joins(:thought).where(:thoughts => {:project_id => self, :state => state.to_s})
  end
end
