class NotifyMailer < ApplicationMailer
    def broker_notify(business)
        @business = business
        @products = InsuranceType.where(id: business.product_IDs)
        mail(to: @business.emails, subject: 'Reminder User')
    end

    def admin_notify(product)
        @product = product
        users = User.where(role: 'Admin')
        users.each do |user|
            mail(to: user.email, subject: 'Reminder Admin')
        end if users.present?
    end
end
