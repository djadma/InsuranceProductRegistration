class UsersController < ApplicationController
    load_and_authorize_resource  through: :current_account
    before_filter :set_current_user

    def index
        @users = @users.search(params)
    end

    def new
        @user = User.new
    end

    def register
        params[:user][:parent_id] = current_user.id
        params[:user][:account_id] = current_account.id
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
        params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :role, :mother_lname, :common, :region, :number, :parent_id, :account_id)
    end
end
