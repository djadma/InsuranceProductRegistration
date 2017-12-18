class InsuranceTypesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource  through: :current_account

  # GET /insurance_types
  # GET /insurance_types.json
  def index
  end

  # GET /insurance_types/new
  def new
    @insurance_type = current_user.insurance_types.new
  end

  # GET /insurance_types/1/edit
  def edit
  end

  # POST /insurance_types
  # POST /insurance_types.json
  def create
    params[:insurance_type][:account_id] = current_account.id
    @insurance_type = current_user.insurance_types.new(insurance_type_params)

    respond_to do |format|
      if @insurance_type.save
        format.html { redirect_to insurance_types_url }
        format.json { render action: 'show', status: :created, location: @insurance_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @insurance_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurance_types/1
  # PATCH/PUT /insurance_types/1.json
  def update
    respond_to do |format|
      if @insurance_type.update(insurance_type_params)
        format.html { redirect_to insurance_types_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @insurance_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_types/1
  # DELETE /insurance_types/1.json
  def destroy
    @insurance_type.destroy
    respond_to do |format|
      format.html { redirect_to insurance_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_type
      @insurance_type = InsuranceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insurance_type_params
      params.require(:insurance_type).permit(:name, :account_id, :fields_attributes => [:id, :field_type, :name, :required, :_destroy])
    end
end
