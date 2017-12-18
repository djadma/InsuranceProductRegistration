class BusinessesController < ApplicationController
    load_and_authorize_resource  through: :current_account
    def new
        @business = current_user.businesses.new
        @products = InsuranceType.joins(:user).where(users: { id: current_user.children.map(&:id).push(current_user.id) })
    end

    def index
        
    end

    def create
        params[:business][:account_id] = current_account.id
        @business = current_user.businesses.new(business_params)
        @products = InsuranceType.joins(:user).where(users: { id: current_user.children.map(&:id).push(current_user.id) })
        respond_to do |format|
            if @business.save
                format.html { redirect_to businesses_url }
                format.json { render action: 'show', status: :created, location: @business }
            else
                format.html { render action: 'new' }
                format.json { render json: @business.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
        @products = InsuranceType.joins(:user).where(users: { id: current_user.children.map(&:id).push(current_user.id) })
    end

    def update
        respond_to do |format|
          if @business.update(business_params)
            format.html { redirect_to businesses_url}
            format.json { head :no_content }
          else
            format.html { redirect_to edit_business_path(@business) }
            format.json { render json: @business.errors, status: :unprocessable_entity }
          end
        end
    end 

    def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url }
      format.json { head :no_content }
    end
  end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
        params.require(:business).permit!
    end
end
