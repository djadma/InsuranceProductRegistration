class Users::SessionsController < Devise::SessionsController
	layout 'empty'
	def new
	  super
	end

	def destroy
		Thread.current[:user] = nil
		super
	end
end