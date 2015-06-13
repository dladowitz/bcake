class UserMailer < ApplicationMailer
  # layout "user_mailer"  # css is not showing up properly when using a layout

  # TODO need to change this to work in production
  RESET_LINK_BASE = "http://localhost:3000/reset_password/"

  def signup_email(user)
    @user = user
    # attachments.inline['logo.png'] = File.read('app/assets/images/cake-logo.png')

    mail(to: @user.email, subject: "Cake - Signup")
  end

  def request_password(user, token)
    @user = user
    @reset_link = RESET_LINK_BASE + token
    # attachments.inline['logo.png'] = File.read('app/assets/images/cake-logo.png')

    mail(to: @user.email, subject: "Cake - Password Reset")
  end
end
