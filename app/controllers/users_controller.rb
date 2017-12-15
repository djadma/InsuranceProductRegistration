class UsersController < ApplicationController
    load_and_authorize_resource
    before_filter :set_current_user

    def index
        @users = User.all_except(current_user)
    end

    def new
        @user = User.new
    end

    def register
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                format.html { redirect_to users_path}
            else
                format.html { render action: 'new' }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @user.update_attributes(user_params)
                format.html { redirect_to users_path}
                format.json { head :no_content }
            else
                format.html { render action: 'edit' }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_path }
          format.json { head :no_content }
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :role)
    end
end
