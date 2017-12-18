class Account < ActiveRecord::Base
	has_many :businesses
	has_many :products
	has_many :insurance_types
	belongs_to :user
	has_many :users
end
