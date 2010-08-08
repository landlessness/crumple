class Person < ActiveRecord::Base
  
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :uniqueness => true,
                    :email => true
  
  has_many :thoughts
  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships
  has_many :drop_boxes, :dependent => :destroy

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings, :uniq => true
  
  after_create do
    self.drop_boxes.create :name => self.email.split('@').first, :secret => rand(9999)
  end
  
  def tags_with_state(state)
    self.tags.joins(:thoughts).where(:thoughts=>{:state=>state.to_s})
  end
  
  def taggings_with_state(state)
    self.taggings.joins(:thought).where(:thoughts=>{:state=>state.to_s})
  end
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  def drop_box
    self.drop_boxes.first
  end
end
