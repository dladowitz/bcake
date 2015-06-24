class VoucherMailer < ApplicationMailer
  # layout "user_mailer"  # css is not showing up properly when using a layout

    def voucher_email(voucher)
      @voucher = voucher
      @location = voucher.location
      @is_birthday = @voucher.customer.birthday.month == Date.today.month

      mail(to: @voucher.customer.email, from: "\"#{@location.name}\" <admin@bcake.co>", subject: "Monthly Deal from #{@location.name}")
      @voucher.update(sent: DateTime.now)
    end
  end
