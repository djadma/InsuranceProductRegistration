class Product < ActiveRecord::Base
  belongs_to :insurance_type
  belongs_to :business
  belongs_to :account
  serialize :properties, Hash
  
  validate :validate_properties
  after_save :notify_admin
  validates :business_id, presence: true
  
  def validate_properties
    insurance_type.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end

  def self.search(params)
    if params[:filter] == "company"
      joins(:business).where("businesses.name = ?", params[:search])
    elsif params[:filter] == "type"
      joins(:business).where("businesses.company_type = ?", params[:search])
    else
      all
    end
  end

  private

  def notify_admin
    users = account.users.where(role: 'Admin')
    users.each do |user|
      NotifyMailer.admin_notify(self, user).deliver
    end if users.present?
  end
end
