class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :insurance_types
  has_many :businesses,:dependent => :destroy
  has_many :products, through: :businesses

  belongs_to :parent, :class_name => 'User'
  belongs_to :account
  has_many :children, :class_name => 'User', :foreign_key => 'parent_id',:dependent => :destroy

  validates :first_name, :last_name, :username, :password, :password_confirmation, :presence => true, :if => :is_super_user?

  
  ROLES = { admin: 'Admin', broker: 'Broker' }

  def is_super_admin?
    parent.blank?
  end
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

  def self.search(params)
    if params[:filter] == "first_name"
      where("first_name = ? or last_name = ?", params[:search], params[:search])
    elsif params[:filter] == "username"
      where("username = ?", params[:search])
    elsif params[:filter] == "role"
      where("role = ?", params[:search].try(:capitalize))
    else
      all
    end
  end
end
