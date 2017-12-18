class ReportsController < ApplicationController
    def index
    	products = Product.joins(:business).where(businesses: { user_id: current_user.children.map(&:id).push(current_user.id) })
        @products = products.search(params)
        respond_to do |format|
            format.html
            format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="all_products.xlsx"'}
        end
    end
end
