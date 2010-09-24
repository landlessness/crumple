class Person < ActiveRecord::Base
  
  has_many :thoughts, :dependent => :destroy
  has_many :plain_text_thoughts
  has_many :comments, :through => :thoughts
  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships
  has_many :drop_boxes, :dependent => :destroy

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings, :uniq => true
  
  has_many :subscriptions
  has_many :pricing_plans, :through => :subscriptions

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
  
  def subscribes_to?(obj)
    logger.info 'top: ' + obj.class.name
    logger.info 'obj.is_a?(PricingPlan) ' + obj.is_a?(PricingPlan).to_s
    if obj.is_a?(AddOn)
      logger.info 'hello: AddOn'
      self.pricing_plans.where(:add_on_id => obj).count > 0
    elsif obj.is_a?(PricingPlan)
      logger.info 'hello: PricingPlan'
      self.pricing_plans.exists?(obj)
    end
  end
end
