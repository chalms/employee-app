class UserMailer < ActionMailer::Base
  default from: 'andrew.n.chalmers@gmail.com'
  layout 'email-template'

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email,
     subject: 'Welcome to Web',
     template_path: 'notifications',
     template_name: 'another')
  end
end
