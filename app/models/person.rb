class Person < ActiveRecord::Base
  has_many :thoughts
  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
end
