class UserMailer < ApplicationMailer
  default :from => 'testerrails.01@gmail.com'
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def password_reset_email(user)
    mail(to: user,
          body: "hello world",
          content_type: "text/html",
          subject: "Already rendered!")
  end
end
