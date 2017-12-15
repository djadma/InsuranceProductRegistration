class ReportsController < ApplicationController
    def index
        @products = Product.search(params)
        respond_to do |format|
            format.html
            format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="all_products.xlsx"'}
        end
    end
end
