class Business < ActiveRecord::Base
  serialize :product_IDs, Array
  #serialize :emails, Array
  belongs_to :user
  has_one :product , :dependent => :destroy
  mount_uploader :logo, LogoUploader

  validates_processing_of :logo
  validate :image_size_validation
  validates :product_IDs, presence: true

  after_save :notify_user


  private

  def notify_user
    NotifyMailer.broker_notify(self).deliver
  end

  def image_size_validation
    errors[:logo] << "should be less than 500KB" if logo.size > 0.5.megabytes
  end
end
