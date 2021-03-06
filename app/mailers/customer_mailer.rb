class CustomerMailer < ApplicationMailer
  # TODO create tests for mailers

  def location_signup_email(customer, location)
    @customer = customer
    @location = location
    @locations = Location.all.limit(5)

    # attachments.inline['logo.png'] = File.read('app/assets/images/cake-logo.png')

    mail(to: @customer.email, from: "\"#{@location.name}\" <admin@bcake.co>", subject: "Thanks from #{@location.name}")
  end

  def contact_email(form_options)
    @name    = form_options[:name]
    @email   = form_options[:email]
    @subject = form_options[:subject]
    @message = form_options[:message]

    mail(to: "david@tradecrafted.com", from: "\"Cake Admin\" <admin@bcake.co>", subject: "Cake: Customer Request for Info")
  end
end
