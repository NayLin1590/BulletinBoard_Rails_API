class ApplicationMailer < ActionMailer::Base
  default from: 'testerrails01@gmail.com'
  layout 'password_reset_email'
end
