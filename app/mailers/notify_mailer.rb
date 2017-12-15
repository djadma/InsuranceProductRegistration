class NotifyMailer < ApplicationMailer
    def broker_notify(business)
        @business = business
        @products = InsuranceType.where(id: business.product_IDs)
        mail(to: @business.emails, subject: 'Reminder User')
    end

    def admin_notify(product)
        @product = product
        @user = product.insurance_type.user
        mail(to: @user.email, subject: 'Reminder Admin')
    end
end
