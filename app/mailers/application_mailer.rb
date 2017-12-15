class ApplicationMailer < ActionMailer::Base
  default from: "system@reminder.com"
  layout 'mailer'
end
