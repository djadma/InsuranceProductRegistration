module BusinessesHelper
	def get_product_names(business)
		products = InsuranceType.where(id: business.product_IDs)
		str = ''
		products.each {|obj| str = str + obj.name + ' '} if products.present?
		return str
	end
end
