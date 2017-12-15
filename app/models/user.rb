class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :insurance_types
  has_many :businesses

  validates :first_name, :last_name, :username, :password, :password_confirmation, :presence => true, :if => :is_super_user?

  scope :all_except, ->(user) { where.not(id: user) }
  
  ROLES = { admin: 'Admin', broker: 'Broker' }

  def is_admin?
    role == ROLES[:admin]
  end

  def is_broker?
    role == ROLES[:broker]
  end

  def is_super_user?
    User.current.present?
  end

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end
end
