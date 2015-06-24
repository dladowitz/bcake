namespace :vouchers do
  desc "Send vouchers for recent location signups"
  task({:send_new => :environment}) do
    puts "=========== Sending all newly created vouchers.........."

    unsent_vouchers = Voucher.where(sent: nil)
    unsent_vouchers.each do |voucher|
      VoucherMailer.voucher_email(voucher).deliver_now
    end

    puts "=========== Sent #{unsent_vouchers.length} vouchers."
  end
end
