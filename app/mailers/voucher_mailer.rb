class VoucherMailer < ApplicationMailer
  # layout "user_mailer"  # css is not showing up properly when using a layout

    def voucher_demo_email(email, voucher)
      @voucher = voucher
      @location = voucher.location
      @is_birthday = @voucher.customer.birthday.month == Date.today.month

      mail(to: email, subject: "Monthly Deal from #{@location.name}")
    end
  end
