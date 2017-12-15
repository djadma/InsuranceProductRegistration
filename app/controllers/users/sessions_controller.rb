class Users::SessionsController < Devise::SessionsController
	layout 'empty'
	def new
	  super
	end
end