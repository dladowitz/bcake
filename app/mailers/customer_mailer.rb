class CustomerMailer < ApplicationMailer
  # TODO create tests for mailers

  def location_signup_email(customer, location)
    @customer = customer
    @location = location
    @locations = Location.all.limit(5)
    
    attachments.inline['logo.png'] = File.read('app/assets/images/cake-logo.png')

    mail(to: @customer.email, subject: "Thanks from #{@location.name}")
  end

end
