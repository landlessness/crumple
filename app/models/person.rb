class Person < ActiveRecord::Base
  
  has_many :thoughts, :dependent => :destroy
  has_many :plain_text_thoughts
  has_many :comments, :through => :thoughts
  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships
  has_many :drop_boxes, :dependent => :destroy

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings, :uniq => true
  
  has_many :installations
  has_many :add_ons, :through => :installations

  # for developers only
  has_many :developed_add_ons, :class_name => 'AddOn', :foreign_key => 'person_id'  

  after_create do
    self.drop_boxes.create :name => self.email.split('@').first + Time.now.hash.to_s, :secret => rand(9999)
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
  def add_on_installed?(add_on)
    self.add_ons.include?(add_on)
  end
end
