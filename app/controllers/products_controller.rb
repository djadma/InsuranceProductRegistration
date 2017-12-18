class ProductsController < ApplicationController
  layout 'empty'
  skip_before_filter :authenticate_user!
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    insurance_type = InsuranceType.find(params[:insurance_type_id])

    @product = insurance_type.products.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    insurance_type = InsuranceType.find(params[:insurance_type_id])
    params[:product][:account_id] = insurance_type.account.id
    @product = insurance_type.products.new(product_params)
    if @product.save
      flash[:notice] = "Saved successfully"
      redirect_to :action => 'new'
    else
      render action: "new"
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_url
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit!
    end
end