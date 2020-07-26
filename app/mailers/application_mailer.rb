class ApplicationMailer < ActionMailer::Base
  default from: 'admin@bookstore.com'
  layout 'mailer'
end
