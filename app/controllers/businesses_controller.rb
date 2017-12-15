class BusinessesController < ApplicationController
    load_and_authorize_resource
    before_action :set_business, only: [:show, :edit, :update, :destroy]
    def new
        @business = current_user.businesses.new
        @products = InsuranceType.all
    end

    def index
        if current_user.is_admin?
            @businesses = Business.all
        else
            @businesses = current_user.businesses
        end
    end

    def create
        @business = current_user.businesses.new(business_params)
        @products = InsuranceType.all
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
        @products = InsuranceType.all
    end

    def update
        respond_to do |format|
          if @business.update(business_params)
            format.html { redirect_to businesses_url}
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_business
        @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
        params.require(:business).permit!
    end
end
