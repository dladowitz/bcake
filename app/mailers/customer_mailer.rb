class CustomerMailer < ApplicationMailer
  # TODO create tests for mailers

  def location_signup_email(customer, location)
    @customer = customer
    @location = location
    attachments.inline['logo.png'] = File.read('app/assets/images/cake-logo.png')

    mail(to: @customer.email, subject: "Thanks from #{@location.name}")
  end

end
